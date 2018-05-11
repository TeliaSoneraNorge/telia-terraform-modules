# This remote state is readable by several AWS accounts (see "share-states-bucket" module)
data "terraform_remote_state" "cloudtrail_processor" {
  backend = "s3"

  config {
    region  = "${var.terraform_state_region_cloudtrail}"
    bucket  = "${var.terraform_state_bucket_cloudtrail}"
    key     = "${var.terraform_state_region_cloudtrail}/cloudtrail-processor/terraform.tfstate"
    encrypt = true
  }
}

locals {
  global_prefix = "${var.global_name}-${var.aws_region}"

  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.global_prefix}-cloudtrail"
}

resource "aws_cloudtrail" "this" {
  name = "${var.global_name}"

  is_multi_region_trail      = "${var.multi_region_trail}"
  enable_logging             = "${var.enable_logging}"
  enable_log_file_validation = "${var.enable_log_file_validation}"

  s3_bucket_name = "${data.terraform_remote_state.cloudtrail_processor.this_s3_bucket_id}"

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.this.arn}"
  cloud_watch_logs_role_arn  = "${aws_iam_role.cloudtrail.arn}"

  tags = "${local.tags}"
}

resource "aws_iam_role" "cloudtrail" {
  name               = "${local.global_prefix}-cloudtrail-role"
  assume_role_policy = "${data.aws_iam_policy_document.cloudtrail_assume_policy.json}"
}

resource "aws_iam_policy" "cloudtrail" {
  name   = "${local.global_prefix}-cloudtrail-policy"
  policy = "${data.aws_iam_policy_document.cloudtrail_policy.json}"
}

resource "aws_iam_policy_attachment" "cloudtrail" {
  name       = "${local.global_prefix}-cloudtrail-policy-attachment"
  policy_arn = "${aws_iam_policy.cloudtrail.arn}"
  roles      = ["${aws_iam_role.cloudtrail.name}"]
}
