variable "is_dead_letter_queue" {
  description = "Whether this should be created as dead-letter queue (means, no redrive policy)"
  default     = false
}

variable "queue_name_prefix" {
  description = "A queue name prefix, typically name of team/project, eg: cpa-event"
}

variable "dead_letter_target_arn" {
  description = "ARN of dead-letter queue to use as target for this queue (useful if dead-letter queue is in different AWS account)"
  default     = ""
}

variable "dead_letter_queue_name" {
  description = "Name of dead-letter queue to use as target for this queue (useful if dead-letter queue is in the same AWS account)"
  default     = ""
}

variable "max_receive_count" {
  description = "The number of times a message is delivered to the source queue before being moved to the dead-letter queue."
  default     = 50
}

###########################

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  default     = 345600
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
  default     = 262144
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  default     = 0
}

variable "policy" {
  description = "The JSON policy for the SQS queue"
  default     = ""
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string (\"5\")"
  default     = ""
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}
