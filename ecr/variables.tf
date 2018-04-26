variable "repo_name" {
  description = "The name for the ECR container repository."
}

variable "trusted_accounts" {
  type        = "list"
  description = "The list of accounts that will get pull access to the ECR repositories."
}
