data "aws_region" "current" {}

data "template_file" "main" {
  template = "${file("../../cluster/cloud-config.yml")}"

  vars {
    region           = "${data.aws_region.current.name}"
    stack_name       = "${var.prefix}-cluster-spotfleet"
    log_group_name   = "${aws_cloudwatch_log_group.main.name}"
    ecs_cluster_name = "${aws_ecs_cluster.main.name}"
    ecs_log_level    = "${var.ecs_log_level}"
  }
}

module "spotrequest" {
  source          = "../../ec2/spot-request"
  prefix          = "${var.prefix}"
  target_capacity = "${var.target_capacity}"
  spot_price      = "${var.spot_price}"
  vpc_id          = "${var.vpc_id}"
  user_data       = "${data.template_file.main.rendered}"
  subnet_count    = "${var.subnet_count}"
  subnet_ids      = "${var.subnet_ids}"
}

data "aws_iam_policy_document" "permissions" {
  # TODO: Restrict privileges to specific ECS services.
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
    ]
  }

  statement {
    effect = "Allow"

    resources = [
      "${aws_cloudwatch_log_group.main.arn}",
    ]

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role_policy" "ec2-permissions" {
  policy = "${data.aws_iam_policy_document.permissions.json}"
  role   = "${module.spotrequest.role_name}"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-spotfleet"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.prefix}-cluster-agent"
}

resource "aws_security_group_rule" "ingress" {
  count                    = "${var.load_balancer_count}"
  security_group_id        = "${module.spotrequest.security_group_id}"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "32768"
  to_port                  = "65535"
  source_security_group_id = "${element(var.load_balancers, count.index)}"
}
