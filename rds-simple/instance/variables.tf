# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "prefix" {
  description = "A prefix used for naming resources."
}

variable "username" {
  description = "Username."
}

variable "password" {
  description = "Password."
}

variable "port" {
  description = "Database port."
  default     = "5439"
}

variable "engine" {
  description = "Type of DB engine."
  default     = "postgres"
}

variable "instance_type" {
  description = "Type of DB instance to provision."
  default     = "db.m3.medium"
}

variable "storage_size" {
  description = "Storage allocated for the DB."
  default     = "50"
}

variable "vpc_id" {
  description = "ID of the VPC for the subnets."
}

variable "subnet_ids" {
  description = "ID of subnets for the RDS subnet group."
  type        = "list"
}

variable "multi_az" {
  description = "Optional: Disable multiple availability zones for the DB instance."
  default     = "true"
}

variable "public_access" {
  description = "Flag whether the DB should be publicly accessible."
  default     = "false"
}

variable "db_name" {
  description = "Optional: The name of the database to create when the DB instance is created."
  default     = "main"
}

variable "snapshot_identifier" {
  description = "Optional: Restore the DB instance from a snapshot."
  default     = ""
}

variable "skip_final_snapshot" {
  description = "Flag whether to skip the final snapshot."
  default     = "true"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}
