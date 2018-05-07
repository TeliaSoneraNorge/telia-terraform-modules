variable "subnets" {
  type = "list"

  default = [
    "abc",
    "def",
    "ghi",
  ]
}

variable "subnet_count" {
  default = "3"
}

variable "prefix" {
  default = "working-example"
}

variable "ami" {
  default = "ami-2d386654"
}

resource "aws_iam_role" "spotfleet" {
  name               = "${var.prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

data "null_data_source" "m3-large" {
  count = "${var.subnet_count}"

  inputs = {
    subnet_id     = "${element(var.subnets, count.index)}"
    ami           = "${var.ami}"
    instance_type = "m3.large"
  }
}

resource "aws_spot_fleet_request" "main" {
  iam_fleet_role       = "${aws_iam_role.spotfleet.arn}"
  launch_specification = "${data.null_data_source.m3-large.*.outputs}"
  spot_price           = "0.03"
  target_capacity      = "6"
  allocation_strategy  = "lowestPrice"
  valid_until          = "2028-05-03T00:00:00Z"
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
