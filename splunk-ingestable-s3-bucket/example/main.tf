module "splunk_ingestable_s3_bucket" {
  source              = "../"
  splunk_account_id   = "245629465185"
  log_bucket_name     = "splunk-s3-test"
  aws_organization_id = "o-wpral5esws"

  tags = {
    project     = "example"
    environment = "dev"
  }
}
