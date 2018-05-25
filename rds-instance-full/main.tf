data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/vpc/${lookup(var.terraform_state_keys, "vpc", "terraform")}.tfstate"
  }
}

resource "random_string" "generated_db_password" {
  length = 16
  upper  = true
  lower  = true
  number = true
  special = "${substr(var.engine, 0, 6)   == "oracle" ? false : true}"
}

locals {
  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"

  identifier = "${join("-", compact(list(var.global_project, var.local_environment, var.local_identifier)))}"

  db_password = "${var.database_password == "" ? random_string.generated_db_password.result : var.database_password}"
}

module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.identifier}-rds"
  description = "Security group with RDS ports open within VPC"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress_cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr_block}"]
  ingress_rules       = ["${var.ingress_rule}"]
}

data "aws_db_snapshot" "manual" {
  count = "${var.manual_db_snapshot_identifier == "" ? 0 : 1}"

  most_recent            = true
  snapshot_type          = "manual"
  db_snapshot_identifier = "${var.manual_db_snapshot_identifier}"
}

######
# RDS
######
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.13.0"

  identifier = "${local.identifier}"

  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  multi_az          = "${var.multi_az}"

  name     = "${var.database_name}"
  username = "${var.database_username}"
  password = "${local.db_password}"

  port = "${var.database_port}"

  snapshot_identifier = "${join("", data.aws_db_snapshot.manual.*.db_snapshot_arn)}"

  vpc_security_group_ids  = ["${module.rds_security_group.this_security_group_id}"]
  maintenance_window      = "${var.maintenance_window}"
  backup_window           = "${var.backup_window}"
  backup_retention_period = "${var.backup_retention_period}"
  monitoring_interval     = "${var.monitoring_interval}"
  monitoring_role_name    = "${local.identifier}-RDSMonitoringRole"
  create_monitoring_role  = true

  # DB subnet group
  subnet_ids = ["${data.terraform_remote_state.vpc.database_subnets}"]

  # DB parameter group
  family = "${var.family}"

  tags = "${local.tags}"

  parameters = "${var.parameters}"

  license_model = "${var.license_model}"
}

######
# SSM
######
resource "aws_ssm_parameter" "database_url" {
  name  = "/${var.local_environment}/${var.database_name}/db/url"
  value = "${module.rds.this_db_instance_endpoint}"
  type  = "String"
}

resource "aws_ssm_parameter" "database_username" {
  name  = "/${var.local_environment}/${var.database_name}/db/username"
  value = "${var.database_username}"
  type  = "String"
}

resource "aws_ssm_parameter" "database_password" {
  name  = "/${var.local_environment}/${var.database_name}/db/password"
  value = "${local.db_password}"
  type  = "SecureString"
}
