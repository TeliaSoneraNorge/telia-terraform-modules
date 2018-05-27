output "aws_lambda_arn" {
  description = "The ARN of the lambda function that forwards Cloud Watch logs to the remote Bucket "
  value       = "${aws_lambda_function.bucket_forwarder.arn}"
}
