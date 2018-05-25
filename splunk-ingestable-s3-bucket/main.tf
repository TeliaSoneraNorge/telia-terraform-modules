// S3 Bucket with a Lifecycle Policy that will delete items older that 7 days
resource "aws_s3_bucket" "this" {
  bucket = "${var.log_bucket_name}"
  acl    = "private"

  lifecycle_rule {
    id      = "auto-delete-after-${var.expiration_days}-days"
    prefix  = ""
    enabled = true

    expiration {
      days = "${var.expiration_days}"
    }
  }

  tags = {
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

// Policy for the bucket with READ and LIST permissions given to the splunk account, Other accounts
// Belonging to the organizaion are only allowed to Put objects to this bucket .

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
      "s3:ObjectCreated:*",
    ]

    filter_suffix = ""
  }

  depends_on = [
    "aws_sns_topic.bucket_events",
  ]
}

resource "aws_sns_topic" "bucket_events" {
  name = "s3-notification-topic-${var.log_bucket_name}"
}

resource "aws_sns_topic_policy" "default" {
  arn    = "${aws_sns_topic.bucket_events.arn}"
  policy = "${data.aws_iam_policy_document.sns_policy.json}"
}

data "aws_iam_policy_document" "sns_policy" {
  statement {
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = [
        "${aws_s3_bucket.this.arn}",
      ]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.bucket_events.arn}",
    ]

    sid = "allowpublish"
  }

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:Receive",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      values   = ["${aws_sqs_queue.new_objects.arn}"]
      variable = "aws:SourceArn"
    }

    resources = [
      "${aws_sns_topic.bucket_events.arn}",
    ]

    sid = "sid_allow_subscribe"
  }
}

// Queue that Splunk will subscribe to
resource "aws_sqs_queue" "new_objects" {
  name                       = "new-objects-for-${var.log_bucket_name}"
  visibility_timeout_seconds = "${var.sqs_visibility_timeout_seconds}"
  message_retention_seconds  = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds  = "${var.sqs_receive_wait_time_seconds}"
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dlq.arn}\",\"maxReceiveCount\":4}"
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [
        "*",
      ]

      type = "AWS"
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${aws_sqs_queue.new_objects.arn}",
    ]

    condition {
      test = "ArnEquals"

      values = [
        "${aws_sns_topic.bucket_events.arn}",
      ]

      variable = "aws:SourceArn"
    }
  }
}

// Dead Letter queue, use same paras as main queue
resource "aws_sqs_queue" "dlq" {
  name                      = "application-logs-dlq-${var.log_bucket_name}"
  message_retention_seconds = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds = "${var.sqs_receive_wait_time_seconds}"
}

resource "aws_sqs_queue_policy" "bucket_can_publish" {
  policy    = "${data.aws_iam_policy_document.sqs_queue_policy.json}"
  queue_url = "${aws_sqs_queue.new_objects.id}"
}

resource "aws_sns_topic_subscription" "bucket_change_notification_to_queue" {
  topic_arn = "${aws_sns_topic.bucket_events.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.new_objects.arn}"
}
