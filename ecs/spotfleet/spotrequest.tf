data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh")}"

  vars {
    region                    = "${data.aws_region.current.name}"
    ecs_cluster_name          = "${aws_ecs_cluster.main.name}"
    ecs_log_level             = "${var.ecs_log_level}"
    cloudwatch_log_group_name = "${aws_cloudwatch_log_group.main.name}"
  }
}

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

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = "${local.spot_fleet_tags}"

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = "${data.template_file.user_data.rendered}"
  }
}
