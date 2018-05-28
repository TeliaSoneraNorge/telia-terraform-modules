module "splunk_ingestable_s3_bucket" {
  source              = "../"
  read_access_account = "0123456789"
  log_bucket_name     = "some-bucket-name"
  aws_organization_id = "o-organizaonid"

  tags = {
    project     = "example"
    environment = "dev"
  }
}
