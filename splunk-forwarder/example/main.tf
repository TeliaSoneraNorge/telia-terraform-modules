locals {
  log_groups = [
    "privacyhub-stage-helpdeskservice",
  ]

  filters = [
    "",
  ]
}

module "cloundwatch_splunk_lambda_subscription" {
  source          = "../../splunk-forwarder"
  log_group_names = "${local.log_groups}"
  filter_patterns = "${local.filters}"
}
