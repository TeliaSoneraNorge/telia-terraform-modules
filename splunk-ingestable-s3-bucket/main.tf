// S3 Bucket with a Lifecycle Policy that will delete items older that 7 days
resource "aws_s3_bucket" "this" {
  bucket = "${var.log_bucket_name}"
  acl = "private"

  lifecycle_rule {
    id = "auto-delete-after-${var.expiration_days}-days"
    prefix = ""
    enabled = true

    expiration {
      days = "${var.expiration_days}"
    }
  }

  tags = {
    Project = "${var.project}"
    Environment = "${var.environment}"
  }
}

// Policy for the bucket with READ and LIST permissions given to the Splunk Prod account, Other accounts
// Belonging to the organizaion are allowed to Put objects to this bucket .

resource "aws_s3_bucket_policy" "application_bucket_policy" {
  bucket = "${aws_s3_bucket.this.id}"
  policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Sid": "splunk_access",
         "Effect": "Allow",
         "Principal": {
            "AWS" : "arn:aws:iam::${var.splunk_account_id}:root"
         },
         "Action": [
            "s3:Get*",
            "s3:List*"
         ],
         "Resource": [
            "arn:aws:s3:::${var.log_bucket_name}"
         ]
      },
      {
         "Sid": "all_accounts_in_organization_can_put_object_access",
         "Effect": "Allow",
         "Principal": "*",
         "Action": [
            "s3:Put*"
         ],
         "Condition": {
            "StringEquals":
                {
                "aws:PrincipalOrgID":["${var.aws_organization_id}"]
                }
         },
         "Resource": [
            "arn:aws:s3:::${var.log_bucket_name}/*"
         ]
      }
   ]
}
POLICY
}

// S3 Bucket event notification that gets triggered on new items

resource "aws_s3_bucket_notification" "object_created" {
  bucket = "${aws_s3_bucket.this.id}"

  topic {
    topic_arn = "${aws_sns_topic.bucket_events.arn}"
    events = [
      "s3:ObjectCreated:*"]
    filter_suffix = ""
  }
  depends_on = ["aws_sns_topic.bucket_events"]
}

// SNS Topic That will be notified when a bucket receives a new object, only allows events
// from the applicaion logs bucket

resource "aws_sns_topic" "bucket_events" {
  name = "application-logs-notification-topic-${var.log_bucket_name}"
  policy = "${aws_sns_topic_policy.allow_pub_sub.id}"
}


// Lets the S3 bucket push messages, and the SQS Queue to subscribe
resource "aws_sns_topic_policy" "allow_pub_sub" {
  arn = "${aws_sns_topic.bucket_events.arn}"
  policy = <<POLICY
  {
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {"AWS":"*"},
        "Action": "SNS:Publish",
        "Resource": "${aws_sns_topic.bucket_events.arn}",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.this.arn}"}
        }
    },
    {
        "Sid": "subs",
        "Effect": "Allow",
        "Principal": {"AWS":"${aws_sqs_queue.new_objects.arn}"},
        "Action": [
          "SNS:Subscribe",
          "SNS:Receive"
          ],
        "Resource": "${aws_sns_topic.bucket_events.arn}",
    }]
}
POLICY
}

// Queue that Splunk will subscribe to
resource "aws_sqs_queue" "new_objects" {
  name                       = "new-objects-for-${var.log_bucket_name}"
  visibility_timeout_seconds = "${var.sqs_visibility_timeout_seconds}"
  message_retention_seconds  = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds  = "${var.sqs_receive_wait_time_seconds}"
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.application_logs_sqs_dlq.arn}\",\"maxReceiveCount\":4}"
}

// Allows the SNS topic to put messages onto the queue

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = "${aws_sqs_queue.new_objects.id}"
  policy = <<POLICY
   {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Sid1520924387867",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "${aws_sqs_queue.new_objects.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.bucket_events.arn}"
        }
      }
    }
  ]
 }
POLICY
}

// Dead Letter queue
resource "aws_sqs_queue" "application_logs_sqs_dlq" {
  name = "application-logs-dlq-${var.log_bucket_name}"
  message_retention_seconds = 86400
  receive_wait_time_seconds = 20
}

resource "aws_sns_topic_subscription" "bucket_change_notification_to_queue" {
  topic_arn = "${aws_sns_topic.bucket_events.arn}"
  protocol = "sqs"
  endpoint = "${aws_sqs_queue.new_objects.arn}"
}
