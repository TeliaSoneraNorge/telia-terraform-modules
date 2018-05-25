variable "splunk_account_id" {
  description = "The id of the account where the Splunk will ingest files from"
}

variable "log_bucket_name" {
  description = "The name of the bucket created for log files"
}

variable "project" {
  description = "A identifier for your project"
}

variable "environment" {
  description = "A identifier for your environment (test/dev/qa etc)"
}

variable "expiration_days" {
  description = "The number of days log files will stay in the bucket"
  default     = "7"
}

variable "aws_organization_id" {
  description = "All member accounts of this organization can Put objects to the bucket"
}

variable "sqs_visibility_timeout_seconds" {
  description = "Visibility timeout for the SQS queue"
  default     = "600"
}

variable "sqs_message_retention_seconds" {
  description = "Message retention for the SQS queue"
  default     = "1209600"
}

variable "sqs_receive_wait_time_seconds" {
  description = "Receive wait time for the SQS queue"
  default     = "20"
}
