[diagram]: img/architecture.png "Architecture overview"
# Splunk forwarder for Cloud Watch Log group subscriptions

This module lets you forward logs from Cloud Watch Logs in your account to an S3 bucket. The module creates Cloud Watch subscriptions for one or more Log groups, and targets the subscription to a Lambda function that is provisioned by this module. 

## Prerequisites  
You need to upload the lambda artifact to an S3 bucket  under your control before you attempt apply this module.  [The Lambda artifact can be found here](https://github.com/TeliaSoneraNorge/cloudwatch-subscriptions-s3-writer)

## Architectural overview 

![alt text][diagram]

The Lambda function forwards your Cloud Watch logs that match the subscription filter, to a bucket in any account.  

## How to use this module

See the example 
