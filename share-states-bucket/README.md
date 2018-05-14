# share-states-bucket

Terraform module which change S3 bucket policy to allow read-only access from the list of specified AWS accounts.

Normally this is needed to enable `cloudtrail-forwarder` to get values of central S3 bucket created by `cloudtrail-processor` in separate AWS account.