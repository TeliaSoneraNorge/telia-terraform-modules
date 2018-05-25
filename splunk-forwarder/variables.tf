variable "filter_patterns" {
  description = "The Cloud Watch filter expression"
  default     = []
  type        = "list"
}

variable "log_group_names" {
  description = "The log group"
  default     = []
  type        = "list"
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
  description = "The bucket where the lambda function that is a Cloud Watch subscription target, is uploaded"
}

variable "lambda_artifact_s3_key" {
  default     = "cloudwatch-logs-remote-bucket-1.0-SNAPSHOT.zip"
  description = "The s3 key pointing to the Lambda function."
}

variable "log_bucket_name" {
  description = "The bucket that the logs will be forwared to, and ingested by splunk. Defaults to production bucket"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function that moves cloudwatch logs to S3 "
}
