// Creates S3 and other resources that enables Splunk to use SQS bases S3 ingestion
resource "random_integer" "id" {
  max = 10000
  min = 0
}
module "splunk_ingestable_s3_bucket" {
  source = "../"
  splunk_account_id = "245629465185"
  log_bucket_name = "splunk-s3-test-${random_integer.id.result}"
  project = "example"
  environment = "dev"
}
