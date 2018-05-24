# Splunk forwarder for CloudWatch Log group subscriptions

![alt text][logo]

This module creates one or more CloudWatch subscriptions for one or more CloudWatch Log groups. 

The module will provision a lambda function in the account that will act as a target for the subscriptions. The Lambda function artifact is located in the *telia-common-logs-prod* account and is maintained there. 

The Lambda function forwards CloudWatch logs to a bucket called *telia-common-logs-prod-application-logs* in the common logs account. 

[logo]: img/architecture.png "Architecture overview"

## How to use this module

To use this module, simply create a map, where the key is a log grop in CloudWatch logs and the value a [Cloudwatch filter expression](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)

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


