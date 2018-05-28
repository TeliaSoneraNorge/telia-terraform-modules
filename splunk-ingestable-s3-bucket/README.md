# S3 bucket and support infrastructure for "Splunk SQS based S3 ingestion"
This module creates an s3 bucket and other infrastrucutre (SNS, SQS, IAM) that can hold files to be ingested by Splunk using [SQS Based S3 ingestion](http://docs.splunk.com/Documentation/AddOns/released/AWS/SQS-basedS3)

#Please Note

* The bucket is created with a lifecycle policy that will, by default, remove items after 7 days. Splunk should be able to ingest the files in that time period 
* All accounts in the organization given by the aws_organization_id can put objects in the created bucket, but they have no read access 
* One dedicated account have read access to the bucket. This will typically be the AWS account hosting Splunk
* The module provisions SQS and SNS resources and required policies. Attributes of the SQS queue can be overridden by setting variables. 
