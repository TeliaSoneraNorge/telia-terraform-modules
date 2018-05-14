data "aws_caller_identity" "this" {}

locals {
  terraform_states_bucket = "terraform-states-${data.aws_caller_identity.this.account_id}"
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "AllowReadOnlyAccessFromOtherAWSAccounts"
    effect = "Allow"

    principals = {
      type        = "AWS"
      identifiers = ["${var.iam_arns_allowed_to_read_terraform_states_for_current_aws_account}"]
    }

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "arn:aws:s3:::${local.terraform_states_bucket}",
      "arn:aws:s3:::${local.terraform_states_bucket}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = "${local.terraform_states_bucket}"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"
}
