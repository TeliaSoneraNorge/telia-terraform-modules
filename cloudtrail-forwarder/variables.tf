variable "terraform_state_region_cloudtrail" {
  description = "AWS region used for Terraform state of cloudtrail-processor"
}

variable "terraform_state_bucket_cloudtrail" {
  description = "Name of S3 bucket with Terraform state for cloudtrail-processor"
}

variable "multi_region_trail" {
  description = "Specifies whether the trail is created in the current region or in all regions"
  default     = true
}

variable "enable_logging" {
  description = "Enables logging for the trail"
  default     = true
}

variable "enable_log_file_validation" {
  description = "Specifies whether log file integrity validation is enabled"
  default     = true
}

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = "map"
  default     = {}
}
