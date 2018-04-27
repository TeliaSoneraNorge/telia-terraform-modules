variable "prefix" {}

resource "aws_iam_role" "spotfleet-assume" {
  assume_role_policy = "${var.prefix}-spotfleet-assume"
}

resource "aws_spot_fleet_request" "" {
  iam_fleet_role = ""

  "launch_specification" {
    ami           = ""
    instance_type = ""
  }

  spot_price      = ""
  target_capacity = 0
}

data "aws_iam_policy_document" "${var.prefix}-spotfleet-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}
