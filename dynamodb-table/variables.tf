variable "name" {
  description = "The name of the table, this needs to be unique within a region"
}

variable "read_capacity" {
  description = "The number of read units for this table"
}

variable "write_capacity" {
  description = "The number of write units for this table"
}

variable "hash_key" {
  description = "The attribute to use as the hash key (the attribute must also be defined as an attribute record)"
  default     = ""
}

variable "range_key" {
  description = "The attribute to use as the range key (the attribute must also be defined as an attribute record)"
  default     = ""
}

variable "attribute" {
  description = "List of attributes"
  type        = "list"
}

variable "server_side_encryption" {
  description = "Whether to enable encryption at rest"
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to DynamoDB table"
  default     = {}
}

variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp in"
  default     = "TimeToExist"
}

variable "ttl_enabled" {
  description = "Indicates whether ttl is enabled (true) or disabled (false)"
  default     = false
}

variable "local_environment" {}
