output "this_cloudwatch_log_group_arn" {
  description = "ARN of the Cloudwatch log group to use for AWS Cloudtrail"
  value       = "${aws_cloudwatch_log_group.this.arn}"
}

output "cloudtrail_iam_role_arn" {
  description = "ARN of the IAM role to use for AWS Cloudtrail"
  value       = "${aws_iam_role.cloudtrail.arn}"
}
