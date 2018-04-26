data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/vpc/${lookup(var.terraform_state_keys, "vpc", "terraform")}.tfstate"
  }
}

data "terraform_remote_state" "s3_buckets" {
  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/s3-buckets/${lookup(var.terraform_state_keys, "s3-buckets", "terraform")}.tfstate"
  }
}

data "terraform_remote_state" "vpc_peering" {
  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/vpc-peering/${lookup(var.terraform_state_keys, "vpc-peering", "terraform")}.tfstate"
  }
}

data "aws_acm_certificate" "this" {
  domain   = "${var.certificate_domain}"
  statuses = ["ISSUED"]
}

locals {
  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"

  subnets = ["${split(",", var.alb_is_internal ? join(",", data.terraform_remote_state.vpc.private_subnets) : join(",", data.terraform_remote_state.vpc.public_subnets))}"]

  alb_security_groups = "${var.alb_is_internal ? module.alb_security_group_internal.this_security_group_id : module.alb_security_group.this_security_group_id}"

  identifier = "${join("-", compact(list(var.global_project, var.local_environment)))}"
}

module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.19.0"

  create      = "${1 - var.alb_is_internal}"
  name        = "${local.identifier}-alb"
  description = "Security group with HTTP port open from VPC"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "alb_security_group_internal" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.19.0"

  create      = "${var.alb_is_internal}"
  name        = "${local.identifier}-alb-internal"
  description = "Security group with HTTP port open from VPCs (this and DirectConnect)"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress_cidr_blocks = [
    "${data.terraform_remote_state.vpc_peering.direct_connect_cidr_block}",
    "${data.terraform_remote_state.vpc.vpc_cidr_block}",
  ]

  ingress_rules = ["https-443-tcp", "all-icmp"]
  egress_rules  = ["all-all"]
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "2.4.0"

  alb_name            = "${local.identifier}${var.alb_prefix}"
  alb_is_internal     = "${var.alb_is_internal}"
  vpc_id              = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets             = ["${local.subnets}"]
  alb_security_groups = ["${local.alb_security_groups}"]
  certificate_arn     = "${data.aws_acm_certificate.this.arn}"

  backend_port             = "${var.backend_port}"
  health_check_path        = "${var.health_check_path}"
  log_bucket_name          = "${data.terraform_remote_state.s3_buckets.logs_s3_bucket_id}"
  log_location_prefix      = "alb"
  alb_protocols            = ["${var.alb_protocols}"]
  force_destroy_log_bucket = false
  create_log_bucket        = false
  enable_logging           = true

  tags = "${local.tags}"
}

data "aws_route53_zone" "this" {
  name         = "${var.route53_zone_name}"
  private_zone = "${var.assign_route53_private_zone}"
}

resource "aws_route53_record" "a" {
  zone_id         = "${data.aws_route53_zone.this.zone_id}"
  name            = "${join(".", compact(list(var.route53_record_prefix, data.aws_route53_zone.this.name)))}"
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = "${module.alb.alb_dns_name}"
    zone_id                = "${module.alb.alb_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "aaaa" {
  zone_id         = "${data.aws_route53_zone.this.zone_id}"
  name            = "${join(".", compact(list(var.route53_record_prefix, data.aws_route53_zone.this.name)))}"
  type            = "AAAA"
  allow_overwrite = true

  alias {
    name                   = "${module.alb.alb_dns_name}"
    zone_id                = "${module.alb.alb_zone_id}"
    evaluate_target_health = true
  }
}
