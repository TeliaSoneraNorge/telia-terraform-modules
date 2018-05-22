resource "aws_iam_role" "lambda_role" {
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
      "Sid": "sdsd"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "allow_cloudwatch" {
  name = "cw_for_lambda"
  description = "Lets the Lambda function write to cloudwatch"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF
}

resource "aws_iam_policy" "allow_s3_puts" {
  name = "s3_for_lambda"
  description = "Lets the Lambda function write to a any bucket"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::telia-common-logs-prod-application-logs/*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_cw_attach" {
  role = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.allow_cloudwatch.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.allow_s3_puts.arn}"
}

resource "aws_lambda_function" "bucket_forwarder" {
  s3_bucket = "telia-common-logs-prod-lambda"
  s3_key = "cloudwatch-logs-remote-bucket-1.0-SNAPSHOT.zip"
  function_name = "telia-common-logs-lambda"
  role = "${aws_iam_role.lambda_role.arn}"
  handler = "com.telia.aws.cloudwatchtoremotebucket.Handler::handleRequest"
  runtime = "java8"
  timeout = 60
  memory_size = 512
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
  count = "${length(var.filter_patterns)}"
  name = "test_lambdafunction_logfilter"
  log_group_name = "${element(var.log_group_names, count.index)}"
  filter_pattern = "${element(var.filter_patterns, count.index)}"
  destination_arn = "${aws_lambda_function.bucket_forwarder.arn}"
}

output "aws_lambda_arn" {
  value = "${aws_lambda_function.bucket_forwarder.arn}"
}
