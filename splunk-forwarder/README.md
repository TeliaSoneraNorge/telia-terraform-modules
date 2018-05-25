[diagram]: img/architecture.png "Architecture overview"
# Splunk forwarder for Cloud Watch Log group subscriptions

This module lets you forward logs from Cloud Watch Logs in your account to Splunk. The module creates Cloud Watch subscriptions Log groups, and targets the subscription to a Lambda function.

[The Lambda artifact can be found here](https://github.com/TeliaSoneraNorge/cloudwatch-subscriptions-s3-writer)

## Architectural overview 

![alt text][diagram]

The Lambda function forwards your Cloud Watch logs that match the subscription filter, to a bucket called in the telia-common-logs-prod account. From there it will be ingested by Splunk. 

## How to use this module

To use this module, simply create a map, where the key is a log grop in Cloud Watch and the value a [Cloudwatch filter expression](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)

