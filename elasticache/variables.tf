# Documentation
# https://www.terraform.io/docs/providers/aws/r/elasticache_cluster.html

variable "prefix" {
  description = "A prefix used for naming resources."
  default     = "main"
}

variable "parameter_group_name" {
  default = "default.memcached1.4"
}

variable "engine" {
  default = "memcached"
}

variable "node_type" {
  default = "cache.t2.micro"
}

variable "num_cache_nodes" {
  default = 2
}

variable "az_mode" {
  default = "cross-az"
}

variable "port" {
  default = 11211
}

variable "vpc_id" {
  description = "ID of the VPC for the subnets."
}

variable "subnet_ids" {
  description = "ID of subnets for the RDS subnet group."
  type        = "list"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}
