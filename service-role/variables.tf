variable "service_role_name" {
  description = "Name for the service role"
}

variable "role_policy_arn" {
  description = "ARN of the policy that should be attached to the role"
}

variable "assuming_principal_identifiers" {
  description = "List of identifiers that should be able to assume this role"
  type        = "list"
}
