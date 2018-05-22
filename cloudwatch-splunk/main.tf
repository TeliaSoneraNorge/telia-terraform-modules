resource "aws_iam_role" "lambda_cloudwatch_subscription_target" {
  name = "iam_for_cloudwatch_subscription_target"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "bucket_forwarder" {
  s3_bucket = "telia-common-logs-prod-lambda"
  filename = "cloudwatch_bucket_forwarder.zip"
  function_name = "telia-common-logs-lambda"
  role = "${aws_iam_role.lambda_cloudwatch_subscription_target.arn}"
  handler = "com.telia.aws.cloudwatchtoremotebucket.Handler::handleRequest"
  runtime = "java8"

  environment {
    variables = {
      bucket_name = "telia-common-logs-prod-application-logs"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.bucket_forwarder.function_name}"
  principal = "logs.amazonaws.com"
}


resource "aws_cloudwatch_log_subscription_filter" "test_lambdafunction_logfilter" {
  count = "${var.filter_}}"
  name = "test_lambdafunction_logfilter"
  log_group_name = "${var.log_group_name}"
  filter_pattern = "${var.filter_pattern}"
  destination_arn = "${var.lambda_arn}"
}


output "aws_lambda_arn" {
  value = "${aws_lambda_function.bucket_forwarder.arn}"
}
