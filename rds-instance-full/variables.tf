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

variable "maintenance_window" {
  description = "Maintenance window. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "03:00-06:00"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = 7
}

variable "monitoring_interval" {
  description = "Monitoring interval for RDS modules"
  default     = 10
}

variable "engine" {
  description = "Engine of RDS"
  default     = "postgres"
}

variable "family" {
  description = "DB parameter group"
  default     = "postgres9.6"
}

variable "ingress_rule" {
  description = "Ingress rule to open the ports towards VPC"
  default     = "postgresql-tcp"
}

variable "parameters" {
  description = "List of parameters for RDS parameter group"
  default     = []
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  default     = ""
}
