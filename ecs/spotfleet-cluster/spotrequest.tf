resource "aws_spot_fleet_request" "main" {
  depends_on     = ["aws_iam_policy_attachment.spotfleet","aws_iam_role_policy.ec2-permissions"]
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

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.xlarge"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.medium"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r3.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "r4.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "c5.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m5.large"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "m3.medium"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "t2.small"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs"] >> /etc/ecs/ecs.config
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
USER_DATA
  }
}
