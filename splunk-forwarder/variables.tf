variable "filter_patterns" {
  description = "The filter expression watch filter for the subscription "
  type        = "list"
  default     = []
}

variable "log_group_names" {
  description = "The log group"
  type        = "list"
  default     = []
}

variable "lambda_timeout_seconds" {
  description = "Timeout for the lambda function that copies log entries to cloudwatch. Modify if you experience timeouts "
  default     = 60
}

variable "lambda_memory_size" {
  description = "Memory allocation for the lambda function that copies log entries to cloudwatch. Modify if you experience out of memory errors"
  default     = 512
}

variable "lambda_bucket" {
  default     = "telia-common-logs-prod-lambda"
  description = "The bucket where the the lambda function that is a Cloud Watch subscription target, is uploaded"
}

variable "lambda_artifact_s3_key" {
  default     = "cloudwatch-logs-remote-bucket-1.0-SNAPSHOT.zip"
  description = "The s3 key pointing to the Java 8 Lambda function."
}

variable "log_bucket_name" {
  default     = "telia-common-logs-prod-application-logs"
  description = "The bucket that the logs will be forwared to, and ingested by splunk. Defaults to production bucket"
}
