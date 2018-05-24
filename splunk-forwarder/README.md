# Splunk forwarder for CloudWatch Log group subscriptions

![alt text][logo]

This module lets you forward logs from Cloud Watch Logs in your account to Splunk. The module creates CloudWatch subscriptions Log groups, and targets the subscrption to a Lambda function.

The Lambda artifact is located in the *telia-common-logs-prod* account and is maintained there. 

The Lambda function forwards your CloudWatch logs that match the subscription filter, to a bucket called in the telia-common-logs-prod account. From there it will be ingested by Splunk. 

[logo]: img/architecture.png "Architecture overview"

## How to use this module

To use this module, simply create a map, where the key is a log grop in CloudWatch and the value a [Cloudwatch filter expression](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)

```
locals {
  subscriptions = {
    privacyhub-stage-helpdeskservice = "{ $.ThisFlag IS TRUE }"
    privacyhub-stage-consentregistry = "{ $.SomeOtherObject NOT EXISTS }"
  }
}

TODO: Create tag, and change reference in the following part of the documentation 

module "cloudwatch_splunk_lambda_subscription" {
  source = "github.com/TeliaSoneraNorge/telia-terraform-modules//splunk-forwarder?ref=master"
"
  log_group_names = "${keys(local.subscriptions)}"
  filter_patterns = "${values(local.subscriptions)}"
}
```


