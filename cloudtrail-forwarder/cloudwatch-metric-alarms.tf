resource "aws_cloudwatch_metric_alarm" "S3BucketActivity" {
  alarm_name          = "CloudTrailS3BucketActivity"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "S3BucketActivityEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to S3 to put or delete a Bucket, Bucket Policy or Bucket ACL."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailSecurityGroupChanges" {
  alarm_name          = "CloudTrailSecurityGroupChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "SecurityGroupEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, update or delete a Security Group."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailNetworkAclChanges" {
  alarm_name          = "CloudTrailNetworkAclChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkAclEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, update or delete a Network ACL."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailGatewayChanges" {
  alarm_name          = "CloudTrailGatewayChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "GatewayEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, update or delete a Customer or Internet Gateway."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailVpcChanges" {
  alarm_name          = "CloudTrailVpcChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "VpcEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, update or delete a VPC, VPC peering connection or VPC connection to classic."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailEC2InstanceChanges" {
  alarm_name          = "CloudTrailEC2InstanceChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EC2InstanceEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, terminate, start, stop or reboot an EC2 instance."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailEC2LargeInstanceChanges" {
  alarm_name          = "CloudTrailEC2LargeInstanceChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EC2LargeInstanceEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, terminate, start, stop or reboot a 4x or 8x-large EC2 instance."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailChanges" {
  alarm_name          = "CloudTrailChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CloudTrailEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to create, update or delete a .cloudtrail. trail, or to start or stop logging to a trail."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailConsoleSignInFailures" {
  alarm_name          = "CloudTrailConsoleSignInFailures"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ConsoleSignInFailureCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "3"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an unauthenticated API call is made to sign into the console."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailAuthorizationFailures" {
  alarm_name          = "CloudTrailAuthorizationFailures"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AuthorizationFailureCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an unauthorized API call is made."
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailIAMPolicyChanges" {
  alarm_name          = "CloudTrailIAMPolicyChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "IAMPolicyEventCount"
  namespace           = "CloudTrailMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${data.terraform_remote_state.cloudtrail_processor.this_sns_topic_arn}"]
  alarm_description   = "Alarms when an API call is made to change an IAM policy."
}
