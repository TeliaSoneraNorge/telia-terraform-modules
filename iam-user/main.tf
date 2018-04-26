data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.0.3"

  name          = "${var.name}"
  path          = "${var.path}"
  force_destroy = true

  pgp_key = "${var.pgp_key}"

  // User should be able to login
  create_iam_user_login_profile = true
  password_reset_required       = false
  password_length               = 20

  // User should create and manage access keys separately, so we don't create them
  create_iam_access_key = false
}
