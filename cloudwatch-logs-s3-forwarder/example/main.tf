# The key of the map is the cloudwatch log group, the value is the filter syntax expression.
# All matching log entries will be forwarded to a Lambda function, that forwards the entries to
# a shared bucket in the telia-common-logs-prod account.

locals {
  subscriptions = {
    privacyhub-stage-helpdeskservice = ""
  }
}

module "cloudwatch_splunk_lambda_subscription" {
  source          = ".."
  log_group_names = "${keys(local.subscriptions)}"
  filter_patterns = "${values(local.subscriptions)}"
  lambda_name     = "telia-log-forwarder"
  lambda_bucket   = "telia-common-logs-prod-lambda"
  log_bucket_name = "telia-common-logs-prod-application-logs"
  lambda_handler  = "com.telia.aws.cloudwatchtoremotebucket.Handler::handleRequest"
  name_prefix     = "send_to_bucket"
  lamda_runtime   = "java8"
}
