# -------------------------------------------------------------------------------
# Resources
# -------------------------------------------------------------------------------
data "aws_region" "current" {}

data "aws_vpc" "concourse" {
  id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "workers_ingress_tsa" {
  security_group_id = "${module.atc.security_group_id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "${var.tsa_port}"
  to_port           = "${var.tsa_port}"
  cidr_blocks       = ["${data.aws_vpc.concourse.cidr_block}"]
}

resource "aws_security_group_rule" "lb_ingress_atc" {
  security_group_id        = "${module.atc.security_group_id}"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "${var.atc_port}"
  to_port                  = "${var.atc_port}"
  source_security_group_id = "${module.external_lb.security_group_id}"
}

resource "aws_autoscaling_attachment" "external_lb" {
  autoscaling_group_name = "${module.atc.id}"
  alb_target_group_arn   = "${aws_lb_target_group.external.arn}"
}

resource "aws_autoscaling_attachment" "internal_lb" {
  autoscaling_group_name = "${module.atc.id}"
  alb_target_group_arn   = "${aws_lb_target_group.internal.arn}"
}

module "atc" {
  source = "../../ec2/asg"

  prefix             = "${var.prefix}-atc"
  user_data          = "${data.template_file.atc.rendered}"
  vpc_id             = "${var.vpc_id}"
  subnet_ids         = "${var.private_subnet_ids}"
  await_signal       = "true"
  pause_time         = "PT5M"
  health_check_type  = "ELB"
  instance_policy    = "${data.aws_iam_policy_document.atc.json}"
  instance_count     = "${var.instance_count}"
  instance_count_max = "${var.instance_count_max}"
  instance_type      = "${var.instance_type}"
  instance_ami       = "${var.instance_ami}"
  instance_key       = "${var.instance_key}"
  tags               = "${var.tags}"
}

data "template_file" "atc" {
  template = "${file("${path.module}/cloud-config.yml")}"

  vars {
    stack_name                = "${var.prefix}-atc-asg"
    region                    = "${data.aws_region.current.name}"
    target_group              = "${aws_lb_target_group.internal.arn}"
    atc_port                  = "${var.atc_port}"
    tsa_port                  = "${var.tsa_port}"
    basic_auth_username       = "${var.basic_auth_username}"
    basic_auth_password       = "${var.basic_auth_password}"
    github_client_id          = "${var.github_client_id}"
    github_client_secret      = "${var.github_client_secret}"
    github_users              = "${length(var.github_users) > 0 ? "Environment=\"CONCOURSE_GITHUB_AUTH_USER=${join(",", var.github_users)}\"" : ""}"
    github_teams              = "${length(var.github_teams) > 0 ? "Environment=\"CONCOURSE_GITHUB_AUTH_TEAM=${join(",", var.github_teams)}\"" : ""}"
    concourse_web_host        = "${lower(var.web_protocol)}://${var.domain != "" ? var.domain : module.external_lb.dns_name}:${var.web_port}"
    concourse_postgres_source = "${var.postgres_connection}"
    log_group_name            = "${aws_cloudwatch_log_group.atc.name}"
    log_level                 = "${var.log_level}"
    tsa_host_key              = "${file("${var.concourse_keys}/tsa_host_key")}"
    session_signing_key       = "${file("${var.concourse_keys}/session_signing_key")}"
    authorized_worker_keys    = "${file("${var.concourse_keys}/authorized_worker_keys")}"
    encryption_key            = "${var.encryption_key}"
    old_encryption_key        = "${var.old_encryption_key}"
  }
}

resource "aws_cloudwatch_log_group" "atc" {
  name = "${var.prefix}-atc"
}

data "aws_iam_policy_document" "atc" {
  statement {
    effect = "Allow"

    resources = [
      "${aws_cloudwatch_log_group.atc.arn}",
    ]

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
    ]
  }

  statement {
    effect = "Allow"

    resources = ["*"]

    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "ec2:DescribeTags",
      "elasticloadbalancing:DescribeTargetHealth",
    ]
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = "${module.external_lb.security_group_id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "${var.web_port}"
  to_port           = "${var.web_port}"
  cidr_blocks       = ["${var.authorized_cidr}"]
}

resource "aws_route53_record" "main" {
  count   = "${var.domain == "" ? 0 : 1}"
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "A"

  alias {
    name                   = "${module.external_lb.dns_name}"
    zone_id                = "${module.external_lb.zone_id}"
    evaluate_target_health = false
  }
}

module "external_lb" {
  source = "../../ec2/lb"

  prefix     = "${var.prefix}-external"
  type       = "application"
  internal   = "false"
  vpc_id     = "${var.vpc_id}"
  subnet_ids = "${var.public_subnet_ids}"
  tags       = "${var.tags}"
}

resource "aws_lb_listener" "external" {
  load_balancer_arn = "${module.external_lb.arn}"
  port              = "${var.web_port}"
  protocol          = "${upper(var.web_protocol)}"
  certificate_arn   = "${var.web_certificate_arn}"
  ssl_policy        = "${var.web_certificate_arn == "" ? "" : "ELBSecurityPolicy-2015-05"}"

  default_action {
    target_group_arn = "${aws_lb_target_group.external.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "external" {
  vpc_id   = "${var.vpc_id}"
  port     = "${var.atc_port}"
  protocol = "HTTP"

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    interval            = "30"
    timeout             = "5"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    matcher             = "200"
  }

  # NOTE: TF is unable to destroy a target group while a listener is attached,
  # therefor we have to create a new one before destroying the old. This also means
  # we have to let it have a random name, and then tag it with the desired name.
  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.tags, map("Name", "${var.prefix}-target-${var.atc_port}"))}"
}

module "internal_lb" {
  source = "../../ec2/lb"

  prefix     = "${var.prefix}-internal"
  type       = "network"
  internal   = "true"
  vpc_id     = "${var.vpc_id}"
  subnet_ids = "${var.private_subnet_ids}"
  tags       = "${var.tags}"
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = "${module.internal_lb.arn}"
  port              = "${var.tsa_port}"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.internal.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "internal" {
  vpc_id   = "${var.vpc_id}"
  port     = "${var.tsa_port}"
  protocol = "TCP"

  health_check {
    protocol            = "TCP"
    port                = "${var.tsa_port}"
    interval            = "30"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
  }

  # NOTE: TF is unable to destroy a target group while a listener is attached,
  # therefor we have to create a new one before destroying the old. This also means
  # we have to let it have a random name, and then tag it with the desired name.
  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.tags, map("Name", "${var.prefix}-target-${var.tsa_port}"))}"
}
