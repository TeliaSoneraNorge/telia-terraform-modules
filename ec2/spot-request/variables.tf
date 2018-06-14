variable "prefix" {
  description = "A prefix used for naming resources."
}

variable "vpc_id" {
  description = "ID of the VPC to be launched into"
}

variable "pre-defined-spotrequest" {
  description = "Which pre defined spot request list to use: small, small-IPv6, medium, medium-IPv6"
  default     = "small"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "instance_ami" {
  description = "ami to use for cluster instances - default is Amazon ESC-optimized AMI in eu-west-1"
  default     = "ami-921423eb"
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

variable "user_data" {
  description = "User data script for the launch configuration."
  default     = ""
}

variable "instance_key" {
  description = "Name of an EC2 key-pair for SSH access."
  default     = ""
}

# Hack to overcome that count variables cannot be inferred
variable "subnet_count" {
  description = "For future use: count of subnets - current predefined spot requests are for 3 subnets"
  default     = 3
}
