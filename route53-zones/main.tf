data "terraform_remote_state" "vpc" {
  count = "${var.create_private_zone}"

  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/vpc/${lookup(var.terraform_state_keys, "vpc", "terraform")}.tfstate"
  }
}

locals {
  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"
}

resource "aws_route53_zone" "public" {
  count = "${var.create_public_zone}"

  name          = "${var.public_zone_name}"
  comment       = "${var.public_zone_comment}"
  force_destroy = "${var.force_destroy}"

  tags = "${local.tags}"
}

resource "aws_route53_zone" "private" {
  count = "${var.create_private_zone}"

  vpc_id        = "${data.terraform_remote_state.vpc.vpc_id}"
  name          = "${var.private_zone_name}"
  comment       = "${var.private_zone_comment}"
  force_destroy = "${var.force_destroy}"

  tags = "${local.tags}"
}
