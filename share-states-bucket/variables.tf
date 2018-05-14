variable "iam_arns_allowed_to_read_terraform_states_for_current_aws_account" {
  description = "List of IAM ARNs (roles or AWS accounts) to allow read-only access to Terraform states in current AWS account"
  type        = "list"
}
