data "aws_region" "current" {}

resource "aws_iam_role" "spotfleet" {
  name               = "${var.prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

data "aws_iam_policy_document" "spotfleet-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2-instance" {
  name               = "${var.prefix}-ec2-instances"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-instance-assume.json}"
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
  role   = "${aws_iam_role.ec2-instance.name}"
}

data "aws_iam_policy_document" "ec2-instance-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "agent-policy" {
  source = "github.com/TeliaSoneraNorge/telia-terraform-modules//ssm/agent-policy?ref=2018.05.07.1"
  prefix = "${var.prefix}"
  role   = "${aws_iam_role.ec2-instance.name}"
  tags   = "${var.tags}"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-spotfleet-cluster"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.prefix}-cluster-agent"
}

resource "aws_security_group" "ecs-instances" {
  name        = "${var.prefix}-ecs-instance"
  description = "Terraformed security group for ${var.prefix} ecs cluster instances"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "ingress" {
  count                    = "${var.load_balancer_count}"
  security_group_id        = "${aws_security_group.ecs-instances.id}"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "32768"
  to_port                  = "65535"
  source_security_group_id = "${element(var.load_balancers, count.index)}"
}

resource "aws_security_group_rule" "egress-all" {
  from_port         = 0
  protocol          = "all"
  security_group_id = "${aws_security_group.ecs-instances.id}"
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.prefix}-ecs-instance"
  role = "${aws_iam_role.ec2-instance.name}"
}
