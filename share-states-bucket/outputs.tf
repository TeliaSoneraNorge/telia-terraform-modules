output "this_s3_bucket_policy_bucket" {
  description = "Name of the bucket"
  value       = "${aws_s3_bucket_policy.this.bucket}"
}

output "this_s3_bucket_policy_policy" {
  description = "Bucket policy"
  value       = "${aws_s3_bucket_policy.this.policy}"
}

output "iam_arns_allowed_to_read_terraform_states_for_current_aws_account" {
  description = "List of IAM ARNs (roles or AWS accounts) to allow read-only access to Terraform states in current AWS account"
  value       = "${var.iam_arns_allowed_to_read_terraform_states_for_current_aws_account}"
}
