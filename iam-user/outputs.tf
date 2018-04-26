output "instructions" {
  value = <<EOF
1. Decrypt your password using your keybase.io account (PGP key: ${var.pgp_key}):

  ${module.iam_user.keybase_password_decrypt_command}

1a. If you are windows user, you can decrypt your password on the keybase website (https://keybase.io/decrypt)
pasting in this message.

${module.iam_user.keybase_password_pgp_message}

2. Log into the console:

  URL:      https://${data.aws_iam_account_alias.current.account_alias}.signin.aws.amazon.com/console
  Username: ${module.iam_user.this_iam_user_name}
  Password: <your-decrypted-password from step 1>

3. Enable virtual MFA using AWS console and [Authy](https://authy.com/):

  https://console.aws.amazon.com/iam/home?region=global#/users/${module.iam_user.this_iam_user_name}?section=security_credentials
${length(module.iam_user.this_iam_access_key_id) > 0 ? "
4. Decrypt your secret access key:

  ${module.iam_user.keybase_secret_key_decrypt_command}

5. Install [vaulted](https://github.com/miquella/vaulted) and add a profile to vaulted:

  $ vaulted add ${data.aws_iam_account_alias.current.account_alias}-${module.iam_user.this_iam_user_name}
  Follow the instructions and add your keys and MFA device:
  Access Key ID: ${module.iam_user.this_iam_access_key_id}
  Secret Access Key: <your-decrypted-secret-access-key from step 4>
  MFA: arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/${module.iam_user.this_iam_user_name}
" : "
4. This user has been created without AWS IAM access keys and they won't be managed through code, use AWS console to generate new.

5. Install [vaulted](https://github.com/miquella/vaulted) and add a profile to vaulted:

  $ vaulted add ${data.aws_iam_account_alias.current.account_alias}-${module.iam_user.this_iam_user_name}
  Follow the instructions and add your keys and MFA device:
  Access Key ID: <your-access-key>
  Secret Access Key: <your-secret-access-key>
  MFA: arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/${module.iam_user.this_iam_user_name}
"}

EOF
}

output "username" {
  description = "The user's name"
  value       = "${module.iam_user.this_iam_user_name}"
}

output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = "${module.iam_user.this_iam_user_arn}"
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = "${module.iam_user.this_iam_user_unique_id}"
}

output "this_iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = "${module.iam_user.this_iam_user_login_profile_key_fingerprint}"
}

output "this_iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = "${module.iam_user.this_iam_user_login_profile_encrypted_password}"
}

output "this_iam_access_key_id" {
  description = "The access key ID"
  value       = "${module.iam_user.this_iam_access_key_id}"
}

output "this_iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = "${module.iam_user.this_iam_access_key_key_fingerprint}"
}

output "this_iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = "${module.iam_user.this_iam_access_key_encrypted_secret}"
}

output "this_iam_access_key_ses_smtp_password" {
  description = "The secret access key converted into an SES SMTP password"
  value       = "${module.iam_user.this_iam_access_key_ses_smtp_password}"
}

output "this_iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = "${module.iam_user.this_iam_access_key_status}"
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = "${module.iam_user.pgp_key}"
}

output "keybase_password_decrypt_command" {
  value = "${module.iam_user.keybase_password_decrypt_command}"
}

output "keybase_password_pgp_message" {
  value = "${module.iam_user.keybase_password_pgp_message}"
}

output "keybase_secret_key_decrypt_command" {
  value = "${module.iam_user.keybase_secret_key_decrypt_command}"
}

output "keybase_secret_key_pgp_message" {
  value = "${module.iam_user.keybase_secret_key_pgp_message}"
}
