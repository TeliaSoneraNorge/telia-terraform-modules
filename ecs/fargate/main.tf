# ------------------------------------------------------------------------------
# AWS
# ------------------------------------------------------------------------------
data "aws_region" "current" {}

# ------------------------------------------------------------------------------
# Cloudwatch
# ------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "main" {
  name              = "${var.prefix}"
  retention_in_days = "${var.log_retention_in_days}"
  tags              = "${var.tags}"
}

# ------------------------------------------------------------------------------
# IAM
# ------------------------------------------------------------------------------
resource "aws_iam_role" "service" {
  name               = "${var.prefix}-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.service_assume.json}"
}

resource "aws_iam_role_policy" "service_permissions" {
  name   = "${var.prefix}-service-permissions"
  role   = "${aws_iam_role.service.id}"
  policy = "${data.aws_iam_policy_document.service_permissions.json}"
}

resource "aws_iam_role" "task" {
  name               = "${var.prefix}-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.task_assume.json}"
}

resource "aws_iam_role_policy" "log_agent" {
  name   = "${var.prefix}-log-permissions"
  role   = "${aws_iam_role.task.id}"
  policy = "${data.aws_iam_policy_document.task_permissions.json}"
}

# ------------------------------------------------------------------------------
# Security groups
# ------------------------------------------------------------------------------
resource "aws_security_group" "ecs_service" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.prefix}-ecs-service-sg"
  description = "Fargate service security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

# ------------------------------------------------------------------------------
# LB Target group
# ------------------------------------------------------------------------------

resource "aws_lb_target_group" "task" {
  vpc_id       = "${var.vpc_id}"
  protocol     = "${var.container_protocol}"
  port         = "${var.container_port}"
  target_type  = "ip"
  health_check = ["${var.health_check}"]

  # NOTE: TF is unable to destroy a target group while a listener is attached,
  # therefor we have to create a new one before destroying the old. This also means
  # we have to let it have a random name, and then tag it with the desired name.
  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.tags, map("Name", "${var.prefix}-target-${var.container_port}"))}"
}

# ------------------------------------------------------------------------------
# ECS Task/Service
# ------------------------------------------------------------------------------
data "null_data_source" "task_environment" {
  count = "${var.task_definition_environment_count}"

  inputs = {
    name  = "${element(keys(var.task_definition_environment), count.index)}"
    value = "${element(values(var.task_definition_environment), count.index)}"
  }
}

resource "aws_ecs_task_definition" "asdf" {
  family                   = "${var.prefix}"
  execution_role_arn       = "${aws_iam_role.task.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.task_definition_cpu}"
  memory                   = "${var.task_definition_ram}"

  container_definitions = <<EOF
[{
    "name": "${var.prefix}",
    "image": "${var.task_definition_image}",
    "essential": true,
    "portMappings": [
        {
            "containerPort": ${var.container_port}
        }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.main.name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "container"
        }
    },
    "environment": ${jsonencode(data.null_data_source.task_environment.*.outputs)}
}]
EOF
}

resource "aws_ecs_service" "service" {
  name                               = "${var.prefix}"
  cluster                            = "${var.cluster_id}"
  task_definition                    = "${aws_ecs_task_definition.asdf.arn}"
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets         = ["${var.private_subnet_ids}"]
    security_groups = ["${aws_security_group.ecs_service.id}"]
  }

  load_balancer {
    container_name   = "${var.prefix}"
    container_port   = "${var.container_port}"
    target_group_arn = "${aws_lb_target_group.task.arn}"
  }
}
