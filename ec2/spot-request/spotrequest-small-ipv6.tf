locals {
  spot_fleet_tags = "${map("Name", "${var.prefix}-spot-instance")}"
}

resource "aws_spot_fleet_request" "main" {
  depends_on     = ["aws_iam_policy_attachment.spotfleet", "aws_iam_role_policy.ec2-permissions"]
  iam_fleet_role = "${aws_iam_role.spotfleet.arn}"

  spot_price          = "${var.spot_price}"
  target_capacity     = "${var.target_capacity}"
  allocation_strategy = "${var.allocation_strategy}"
  valid_until         = "${var.valid_until}"
  count               = "${replace(replace(var.pre-defined-spotrequest,"^(?!"samll-ipv6$)","0"),"^samll-ipv6$","1"}"

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "i3.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "i3.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "i3.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.medium"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.medium"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.medium"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r4.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.large"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.large"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.large"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 2
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.small"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 1
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.small"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 1
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.small"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 1
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
  }
}
