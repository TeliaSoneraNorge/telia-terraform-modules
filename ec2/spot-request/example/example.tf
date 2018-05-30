provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source        = "../../../ec2/vpc"
  prefix        = "your-project"
  cidr_block    = "10.8.0.0/16"
  dns_hostnames = "true"

  tags {
    environment = "prod"
    terraform   = "True"
  }
}

module "spot-request" {
  source     = "../../../ec2/spot-request"
  prefix     = "your-project"
  user_data  = "#!bin/bash\necho hello world"
  vpc_id     = "${module.vpc.vpc_id}"
  subnet_ids = "${module.vpc.public_subnet_ids}"
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = "${module.spot-request.security_group_id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

data "aws_iam_policy_document" "permissions" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:AssociateAddress",
    ]

    resources = ["*"]
  }
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "security_group_id" {
  value = "${module.spot-request.security_group_id}"
}

output "role_arn" {
  value = "${module.spot-request.role_arn}"
}
