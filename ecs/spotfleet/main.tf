resource "aws_iam_role" "spotfleet" {
  name               = "${var.prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

resource "aws_spot_fleet_request" "main" {
  iam_fleet_role = "${aws_iam_role.spotfleet.arn}"

  spot_price          = "${var.spot_price}"
  target_capacity     = "${var.target_capacity}"
  allocation_strategy = "${var.allocation_strategy}"
  valid_until         = "${var.valid_until}"

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.xlarge"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.xlarge"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.xlarge"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.xlarge"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.xlarge"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.xlarge"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.xlarge"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.xlarge"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.xlarge"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.xlarge"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.xlarge"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.xlarge"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.xlarge"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.xlarge"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.xlarge"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c3.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.medium"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.medium"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.medium"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c4.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c4.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c4.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r3.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m4.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m4.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m4.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "r4.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c5.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c5.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "c5.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m5.large"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m5.large"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m5.large"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.medium"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.medium"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "m3.medium"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.small"
    subnet_id         = "${var.subnets[0]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.small"
    subnet_id         = "${var.subnets[1]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }

  launch_specification {
    ami               = "${var.ami}"
    instance_type     = "t2.small"
    subnet_id         = "${var.subnets[2]}"
    weighted_capacity = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }
  }
}

output "subnetsprint" {
  value = "${jsonencode(local.test)}"
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

locals {
  test = [{
    subnet_id         = "${var.subnets[0]}"
    ami               = "${var.ami}"
    instance_type     = "m3.large"
    weighted_capacity = 2
  },
    {
      subnet_id         = "${var.subnets[1]}"
      ami               = "${var.ami}"
      instance_type     = "t2.large"
      weighted_capacity = 2
    },
  ]
}
