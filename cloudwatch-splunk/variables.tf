variable "bucket_arn" {
  description = "The arn of the bucket that can prodice "
}

variable "lambda_arn" {
  description = "Role arn"
}

variable "filter_pattern" {
  description = "The filter expression watch filter for the subscription "
  type = "list"
}

variable "log_group_name" {
  description = "The log group"
  type = "list"
}
