variable "allocated_storage" {
  description = "Allocated storage size"
}

variable "instance_class" {
  description = "DB instance class"
}

variable "engine_version" {
  description = "DB engine version"
}

variable "manual_db_snapshot_identifier" {
  description = "ID of manually created DB snapshot to boot from"
  default     = ""
}

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The database username"
}

variable "database_password" {
  description = "The database password"
  default     = ""
}

variable "database_port" {
  description = "The database port"
}

variable "tags" {
  description = "Map of tags to assign to ALB"
  type        = "map"
  default     = {}
}

variable "multi_az" {
  description = "Specifies if the database should be deployed with standby replica in a different AZ"
  default     = false
}
