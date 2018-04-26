output "this_dynamodb_table_arn" {
  description = "The ARN of the table"
  value       = "${aws_dynamodb_table.this.arn}"
}

output "this_dynamodb_table_id" {
  description = "The name of the table"
  value       = "${aws_dynamodb_table.this.id}"
}
