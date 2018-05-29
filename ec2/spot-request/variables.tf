variable "prefix" {
  description = "A prefix used for naming resources."
}

variable "vpc_id" {
  description = "ID of the VPC to be launched into"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "instance_ami" {
  description = "ami to use for cluster instances - default is Amazon ESC-optimized AMI in eu-west-1"
  default     = "ami-2d386654"
}

variable "target_capacity" {
  description = "The target capacity of the request - in vCPUs"
  default     = "1"
}

variable "spot_price" {
  description = "The maximum price per unit (vCPU) - default is set to roughly on demand price"
  default     = "0.05"
}

variable "allocation_strategy" {
  description = "Optional: Defaulted to lowestPrice - recommend setting diversified for production."
  default     = "lowestPrice"
}

variable "valid_until" {
  description = "Valid to date for the spot requests - after this date instances will not be replaced"
  default     = "2028-05-03T00:00:00Z"
}

variable "subnet_ids" {
  type        = "list"
  description = "List of subnets to launch the spotfleet in"
}

# Hack to overcome that count variables cannot be inferred
variable "subnet_count" {
  description = "Required: count of subnets"
}

variable "user_data" {
  description = "User data script for the launch configuration."
  default     = ""
}
