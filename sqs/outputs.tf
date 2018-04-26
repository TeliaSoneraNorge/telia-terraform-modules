output "this_sqs_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = "${coalesce(module.dead_letter_queue.this_sqs_queue_id, module.queue.this_sqs_queue_id)}"
}

output "this_sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = "${coalesce(module.dead_letter_queue.this_sqs_queue_arn, module.queue.this_sqs_queue_arn)}"
}
