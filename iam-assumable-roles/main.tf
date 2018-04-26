module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "0.0.2"

  trusted_role_arns = "${var.trusted_role_arns}"

  mfa_age = 86400

  create_admin_role       = true
  admin_role_name         = "admin"
  admin_role_requires_mfa = true

  create_poweruser_role       = true
  poweruser_role_name         = "developer"
  poweruser_role_requires_mfa = false

  create_readonly_role       = true
  readonly_role_name         = "readonly"
  readonly_role_requires_mfa = false
}
