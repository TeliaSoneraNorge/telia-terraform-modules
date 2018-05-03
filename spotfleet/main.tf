resource "aws_iam_role" "spotfleet" {
  name = "${var.prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

resource "aws_spot_fleet_request" "main" {
  iam_fleet_role = "${aws_iam_role.spotfleet.arn}"

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "c3.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "t2.medium"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "t2.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "m3.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "c4.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "r3.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "m4.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "r4.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "c5.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "m5.large"
    weighted_capacity = 2
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "m3.medium"
    weighted_capacity = 1
  }

  "launch_specification" {
    ami               = "${var.ami}"
    instance_type     = "t2.small"
    weighted_capacity = 1

  }
  spot_price      = "${var.spot_price}"
  target_capacity = "${var.target_capacity}"
  iam_fleet_role = "arn:aws:iam::12345678:role/spot-fleet"
  allocation_strategy = "${var.allocation_strategy}"
}

data "aws_iam_policy_document" "spotfleet-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}
