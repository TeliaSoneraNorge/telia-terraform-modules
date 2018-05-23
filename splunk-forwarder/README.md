# Splunk forwarder for CloudWatch Log group subscriptions

This module creates one or more CloudWatch subscriptions for one or more CloudWatch Log groups. 

The module will provision a lambda function in the account that will act as a target for the subscriptions. The Lambda function artifact is located in the *telia-common-logs-prod* account and is maintained there. 

The Lambda function forwards CloudWatch logs to a bucket called *telia-common-logs-prod-application-logs* in the common logs account. 

The items in the bucket is later consumed using SQS based S3 ingestion by Splunk. 

## Example usage 

```
locals {
  subscriptions = {
    privacyhub-stage-helpdeskservice = "{ $.ThisFlag IS TRUE }"
    privacyhub-stage-consentregistry = "{ $.SomeOtherObject NOT EXISTS }"
  }
}

module "cloudwatch_splunk_lambda_subscription" {
  source = "../../splunk-forwarder"
  log_group_names = "${keys(local.subscriptions)}"
  filter_patterns = "${values(local.subscriptions)}"
}
```


