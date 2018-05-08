output "this_s3_bucket_id" {
  description = "The name of logs bucket to use for AWS Cloudtrail"
  value       = "${aws_s3_bucket.this.id}"
}

output "this_sns_topic_arn" {
  description = "The ARN of SNS topic to use for AWS Cloudtrail"
  value       = "${aws_sns_topic.this.arn}"
}
