locals {
  global_prefix = "${var.global_name}-${var.aws_region}"
  bucket_name   = "${local.global_prefix}-cloudtrail"
  sns_topic     = "${local.global_prefix}-cloudtrail"

  //  cloudwatch_log_group = "${local.global_prefix}-cloudtrail"

  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"
}

resource "aws_s3_bucket" "this" {
  bucket        = "${local.global_prefix}-cloudtrail"
  region        = "${var.aws_region}"
  acl           = "private"
  policy        = "${data.aws_iam_policy_document.cloudtrail_bucket.json}"
  force_destroy = false

  tags = "${local.tags}"
}

resource "aws_sns_topic" "this" {
  name   = "${local.sns_topic}"
  policy = "${data.aws_iam_policy_document.cloudtrail_alarm_policy.json}"
}
