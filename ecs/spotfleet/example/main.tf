data "aws_region" "current" {}

module "vpc" {
  source          = "../../../ec2/vpc"
  prefix          = "${var.prefix}"
  cidr_block      = "10.1.0.0/16"
  private_subnets = "0"
  tags            = "${var.tags}"
}

module "example_spotfleet" {
  source          = "../"
  prefix          = "${var.prefix}"
  target_capacity = "6"
  subnet_ids      = "${module.vpc.public_subnet_ids}"
  subnet_count    = "3"
  vpc_id          = "${module.vpc.vpc_id}"
}
