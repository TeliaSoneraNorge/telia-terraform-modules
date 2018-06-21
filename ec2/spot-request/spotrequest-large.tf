resource "aws_spot_fleet_request" "large" {
  count               = "${var.pre-defined-spotrequest=="large" ? 1 : 0}"
  depends_on          = ["aws_iam_policy_attachment.spotfleet"]
  iam_fleet_role      = "${aws_iam_role.spotfleet.arn}"
  spot_price          = "${var.spot_price}"
  target_capacity     = "${var.target_capacity}"
  allocation_strategy = "${var.allocation_strategy}"
  valid_until         = "${var.valid_until}"

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r3.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r3.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "r3.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
  }

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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5d.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5d.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
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
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m5.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c5.xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 4
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.2xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.2xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c3.2xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.2xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.2xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "t2.2xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.2xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.2xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m3.2xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.2xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.2xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "c4.2xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.2xlarge"
    subnet_id     = "${var.subnet_ids[0]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.2xlarge"
    subnet_id     = "${var.subnet_ids[1]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }

  launch_specification {
    ami           = "${var.instance_ami}"
    instance_type = "m4.2xlarge"
    subnet_id     = "${var.subnet_ids[2]}"

    vpc_security_group_ids = [
      "${aws_security_group.main.id}",
    ]

    weighted_capacity    = 8
    tags                 = "${local.spot_fleet_tags}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2.name}"
    user_data            = "${var.user_data}"
    key_name             = "${var.instance_key}"
  }
}
