# Cloud Watch Log group subscriptions to S3 forwarder

This module lets you forward logs from Cloud Watch Logs to an S3 bucket. 

The module creates Cloud Watch subscriptions for one or more Log groups, and targets the subscription to a Lambda function that is provisioned by this module. 

You can use filter expressions to copy only a subset of the log entries to S3. 

## Prerequisites  
You need to upload the lambda artifact to an S3 bucket  under your control before you attempt apply this module.  [The Lambda artifact can be found here](https://github.com/TeliaSoneraNorge/cloudwatch-subscriptions-s3-writer)
