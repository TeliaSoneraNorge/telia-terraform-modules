variable "alb_prefix" {
  description = "ALB prefix to append to name (hint: start with '-' or leave empty)"
}

variable "alb_is_internal" {
  description = "Boolean to specify if ALB is internal"
}

variable "alb_protocols" {
  description = "The protocols the ALB accepts. e.g.: [\"HTTP\"]"
  type        = "list"
  default     = ["HTTPS"]
}

variable "certificate_domain" {
  description = "ACM certificate domain to use by this ALB"
}

variable "backend_port" {
  description = "Backend/instance port to use for ALB"
}

variable "health_check_path" {
  description = "Health check path to use for ALB"
}

variable "route53_record_prefix" {
  description = "Route53 record prefix (hint: leave empty to use directly the zone name)"
  default     = ""
}

variable "route53_zone_name" {
  description = "Route53 zone name to assign to this ALB"
}

variable "assign_route53_private_zone" {
  description = "Assign Route53 private zone to this ALB"
}

variable "tags" {
  description = "Map of tags to assign to ALB"
  type        = "map"
  default     = {}
}
variable "terraform_state_keys" {}
variable "terraform_state_region" {}
variable "terraform_state_bucket" {}
variable "aws_region" {}