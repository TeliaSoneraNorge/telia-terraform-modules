resource "aws_spot_fleet_request" "main" {
  depends_on     = ["aws_iam_policy_attachment.spotfleet", "aws_iam_role_policy.ec2-permissions"]
  iam_fleet_role = "${aws_iam_role.spotfleet.arn}"

  spot_price          = "${var.spot_price}"
  target_capacity     = "${var.target_capacity}"
  allocation_strategy = "${var.allocation_strategy}"
  valid_until         = "${var.valid_until}"

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 4

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 2

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[0]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[1]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }

  launch_specification {
    ami                    = "${var.ami}"
    instance_type          = "{{instance_type}}"
    subnet_id              = "${var.subnets[2]}"
    vpc_security_group_ids = ["${aws_security_group.ecs-instances.id}"]
    weighted_capacity      = 1

    tags = {
      "Name" = "${var.prefix}-spot-instance"
    }

    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

    user_data = <<USER_DATA
#!/bin/bash
yum install -y https://amazon-ssm-${data.aws_region.current.name}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${var.ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${data.aws_region.current.name}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${aws_cloudwatch_log_group.main.name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
USER_DATA
  }
}
