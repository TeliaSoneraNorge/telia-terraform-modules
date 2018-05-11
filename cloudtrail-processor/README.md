# cloudtrail-processor

Setup AWS resources required for central AWS Cloudtrail and AWS Config:

* SNS topic
* S3 bucket

SNS subscription is not currently supported by this module, so this has to be done manually once SNS topic is created. (See also https://www.terraform.io/docs/providers/aws/r/sns_topic_subscription.html)

This module should be used only in central Cloudtrail AWS account where S3 bucket lives.