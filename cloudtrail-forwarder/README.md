# cloudtrail-forwarder

Setup AWS resources required for AWS Cloudtrail to work in individual AWS accounts:

* Cloudtrail trail
* Cloudwatch log group
* Cloudwatch rules
* Cloudwatch alarms

This module loads `cloudtrail-processor` Terraform state file to get these values:

* SNS topic
* S3 bucket

This module should be used in all AWS accounts where AWS Cloudtrail should be enabled (including central Cloudtrail account).