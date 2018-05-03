variable "prefix" {
  description = "A prefix used for naming resources."
}

variable "ami" {
  description = "ami to use for cluster instances - default is Amazon ESC-optimized AMI in eu-west-1"
  default     = "ami-2d386654"
}

variable "target_capacity" {
  description = "The target capacity of the request - in vCPUs"
  default     = "4"
}

variable "spot_price" {
  description = "The maximum price per unit (vCPU) - default is set to roughly on demand price"
  default     = "0.05"
}


variable "allocation_strategy" {
  description = "Optional: Defaulted to lowestPrice - recommend setting diversified for production."
  default = "lowestPrice"
}
