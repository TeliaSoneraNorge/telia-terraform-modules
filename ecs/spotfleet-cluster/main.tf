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

resource "aws_iam_policy_attachment" "ec2-instance" {
  name       = "${var.prefix}-ec2-instance"
  roles      = ["${aws_iam_role.ec2-instance.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
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

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.prefix}-ecs-instance"
  role = "${aws_iam_role.ec2-instance.name}"
}
