# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "prefix" {
  description = "Prefix added to the role name."
}

variable "trusted_accounts" {
  type        = "list"
  description = "List of IDs for the accounts which is trusted with access to assume this role."
}

variable "mfa_window" {
  description = "A window in time (hours) after MFA authenticating where the user is allowed to assume the role."
  default     = "1"
}

variable "users" {
  type        = "list"
  description = "List of users in the trusted account which will be allowed to assume this role."
}

variable "role_description" {
  description = "A description to add to the role"
  default     = "Terraform created role"
}

locals {
  trusted_accounts_size = "${length( var.trusted_accounts )}"
  users_size            = "${length( var.users )}"
  arn_list_size         = "${local.accounts_size * local.users_size}"
}

# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
data "aws_iam_account_alias" "current" {}

data "null_data_source" "users" {
  count = "${local.arn_list_size}"

  inputs = {
    users = "${format("arn:aws:iam::%s:user/%s", var.trusted_accounts[count.index % local.accounts_size], var.users[count.index / local.accounts_size])}"
  }
}

resource "aws_iam_role" "main" {
  name                  = "${var.prefix}-role"
  assume_role_policy    = "${data.aws_iam_policy_document.assume.json}"
  force_detach_policies = "true"
  description           = "${var.role_description}"
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = "${data.null_data_source.users.*.outputs.users}"
    }

    condition = {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition = {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = ["${var.mfa_window * 3600}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "view_only_policy" {
  role       = "${aws_iam_role.main.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "name" {
  value = "${aws_iam_role.main.name}"
}

output "arn" {
  value = "${aws_iam_role.main.arn}"
}

output "url" {
  value = "https://signin.aws.amazon.com/switchrole?account=${data.aws_iam_account_alias.current.account_alias}&roleName=${aws_iam_role.main.name}&displayName=${var.prefix}%20@%20${data.aws_iam_account_alias.current.account_alias}"
}
