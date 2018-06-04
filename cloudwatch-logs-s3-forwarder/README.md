# Cloud Watch Log group subscriptions to S3 forwarder

This module lets you forward logs from Cloud Watch Logs to an S3 bucket. 

The module creates Cloud Watch subscriptions for one or more Log groups, and targets the subscription to a Lambda function that is provisioned by this module. The Lambda function base64 deocde and decompress the Cloud Watch payload and moves it to a S3 bucket.

You can use filter expressions to copy only a subset of the log entries. . 
