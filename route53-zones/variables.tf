variable "create_public_zone" {
  description = "Specify true to create Route53 public zone"
  default     = false
}

variable "public_zone_name" {
  description = "Name for public Route53 zone (add . at the end)"
  default     = ""
}

variable "public_zone_comment" {
  description = "Comment for public Route53 zone"
  default     = "Managed by Terraform"
}

variable "create_private_zone" {
  description = "Specify true to create Route53 private zone"
  default     = false
}

variable "private_zone_name" {
  description = "Name for private Route53 zone (add . at the end)"
  default     = ""
}

variable "private_zone_comment" {
  description = "Comment for private Route53 zone"
  default     = "Managed by Terraform"
}

variable "force_destroy" {
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to Route53 zone"
  type        = "map"
  default     = {}
}
