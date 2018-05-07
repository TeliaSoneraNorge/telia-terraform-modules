resource "aws_iam_role" "spotfleet" {
  name               = "${var.prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

//locals {
//  test = [{
//    ami           = "${var.ami}"
//    instance_type = "m3.large"
//  },
//    {
//      ami           = "${var.ami}"
//      instance_type = "t2.large"
//    },
//  ]
//}

data "null_data_source" "spot" {
  count = "${var.subnet_count}"

  inputs = [{
    subnet_id     = "${element(var.subnets, count.index)}"
    ami           = "${var.ami}"
    instance_type = "m3.large"
  },
    {
      subnet_id     = "${element(var.subnets, count.index)}"
      ami           = "${var.ami}"
      instance_type = "t2.large"
    },
  ]
}

locals {
  test = ["${data.null_data_source.spot.*.outputs}"]
}

output "launch_specification" {
  value = "${data.null_data_source.spot.*.outputs}"
}


resource "aws_spot_fleet_request" "main" {
  iam_fleet_role = "${aws_iam_role.spotfleet.arn}"

  launch_specification = ["${local.test}"]

  //   launch_specification = ["${data.null_data_source.spot.*.outputs}"]
  //launch_specification = ["${data.null_data_source.spot3.*.outputs}"]

  spot_price = "${var.spot_price}"
  target_capacity     = "${var.target_capacity}"
  allocation_strategy = "${var.allocation_strategy}"
  valid_until         = "${var.valid_until}"
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
