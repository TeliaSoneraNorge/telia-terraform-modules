# The key of the map is the cloudwatch log group, the value is the filter syntax expression.
# All matching log entries will be forwarded to a Lambda function, that forwards the entries to
# a shared bucket in the telia-common-logs-prod account.

locals {
  subscriptions = {
    privacyhub-stage-helpdeskservice = "{ $.ThisFlag IS TRUE }"
  }
}

module "cloudwatch_splunk_lambda_subscription" {
  source          = "../../splunk-forwarder"
  log_group_names = "${keys(local.subscriptions)}"
  filter_patterns = "${values(local.subscriptions)}"
}
