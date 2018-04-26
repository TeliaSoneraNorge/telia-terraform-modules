data "aws_caller_identity" "current" {
  count = "${var.dead_letter_target_arn == "" ? 1 : 0}"
}

data "aws_region" "current" {
  count = "${var.dead_letter_target_arn == "" ? 1 : 0}"
}

locals {
  aws_region             = "${element(concat(data.aws_region.current.*.name, list("")), 0)}"
  aws_account_id         = "${element(concat(data.aws_caller_identity.current.*.account_id, list("")), 0)}"
  dead_letter_target_arn = "arn:aws:sqs:${local.aws_region}:${local.aws_account_id}:${var.dead_letter_queue_name}"

  redrive_policy = "{\"deadLetterTargetArn\":\"${var.dead_letter_target_arn == "" ? local.dead_letter_target_arn : var.dead_letter_target_arn}\",\"maxReceiveCount\":${var.max_receive_count}}"
}

module "dead_letter_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "1.0.0"

  create = "${var.is_dead_letter_queue}"

  name = "${var.queue_name_prefix}-dlq"

  visibility_timeout_seconds  = "${var.visibility_timeout_seconds}"
  message_retention_seconds   = "${var.message_retention_seconds}"
  max_message_size            = "${var.max_message_size}"
  delay_seconds               = "${var.delay_seconds}"
  receive_wait_time_seconds   = "${var.receive_wait_time_seconds}"
  policy                      = "${var.policy}"
  redrive_policy              = ""
  fifo_queue                  = "${var.fifo_queue}"
  content_based_deduplication = "${var.content_based_deduplication}"

  tags = "${var.tags}"
}

module "queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "1.0.0"

  create = "${1 - var.is_dead_letter_queue}"

  name = "${var.queue_name_prefix}"

  visibility_timeout_seconds  = "${var.visibility_timeout_seconds}"
  message_retention_seconds   = "${var.message_retention_seconds}"
  max_message_size            = "${var.max_message_size}"
  delay_seconds               = "${var.delay_seconds}"
  receive_wait_time_seconds   = "${var.receive_wait_time_seconds}"
  policy                      = "${var.policy}"
  redrive_policy              = "${local.redrive_policy}"
  fifo_queue                  = "${var.fifo_queue}"
  content_based_deduplication = "${var.content_based_deduplication}"

  tags = "${var.tags}"
}
