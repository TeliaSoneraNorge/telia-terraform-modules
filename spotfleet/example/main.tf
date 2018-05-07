data "aws_region" "current" {}

module "vpc" {
  source          = "../../ec2/vpc"
  prefix          = "${var.prefix}"
  cidr_block      = "10.1.0.0/16"
  tags            = "${var.tags}"
  private_subnets = "0"
}

module "example_spotfleet" {
  source          = "../../spotfleet"
  prefix          = "${var.prefix}"
  target_capacity = 6
  spot_price      = "0.02"
  tags            = "${var.tags}"
  subnets         = "${module.vpc.public_subnet_ids}"
  subnet_count    = "3"
}
