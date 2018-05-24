variable "filter_patterns" {
  description = "The filter expression watch filter for the subscription "
  type = "list"
}

variable "log_group_names" {
  description = "The log group"
  type = "list"
}

variable "lambda_bucket" {
  default = "telia-common-logs-prod-lambda"
  description = "The bucket where the the lambda function that is a Cloud Watch subscription target, is uploaded"
}

variable "lambda_artiact_s3_key" {
  default = "cloudwatch-logs-remote-bucket-1.0-SNAPSHOT.zip"
  description = "The s3 key pointing to the Java 8 Lambda function."
}

variable "log_bucket_name" {
  default = "telia-common-logs-prod-application-logs"
  description = "The bucket that the logs will be forwared to, and ingested by splunk. Defaults to production bucket"
}
