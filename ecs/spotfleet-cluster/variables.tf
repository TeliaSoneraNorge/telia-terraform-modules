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
  default     = "lowestPrice"
}

variable "valid_until" {
  description = "Valid to date for the spot requests - after this date instances will not be replaced"
  default     = "2028-05-03T00:00:00Z"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "subnets" {
  type        = "list"
  description = "List of subnets to launch the spotfleet in"
}

# Hack to overcome that count variables cannot be inferred
variable "subnet_count" {
  description = "Required: count of subnets"
}

variable "ecs_log_level" {
  description = "Log level for the ECS agent."
  default     = "info"
}

variable "load_balancers" {
  description = "List of load balancer security groups that can ingress on the dynamic port range."
  type        = "list"
  default     = []
}

variable "load_balancer_count" {
  description = "HACK: This exists purely to calculate count in Terraform. Should equal the length of your ingress map."
  default     = 0
}
