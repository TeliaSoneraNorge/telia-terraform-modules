#!/bin/bash
yum install -y https://amazon-ssm-${region}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y awslogs
yum install -y aws-cfn-bootstrap
echo ECS_CLUSTER=${ecs_cluster_name} >> /etc/ecs/ecs.config
echo ECS_LOG_LEVEL=${ecs_log_level} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"] >> /etc/ecs/ecs.config

mkdir /etc/awslogs

echo "[plugins]" > /etc/awslogs/awscli.template
echo "cwlogs = cwlogs" >> etc/awslogs/awscli.template
echo "[default]" >> etc/awslogs/awscli.template
echo "region = ${region}" >> etc/awslogs/awscli.template

echo [general] > /etc/awslogs/awslogs.template
echo "state_file = /var/lib/awslogs/agent-state" >> /etc/awslogs/awslogs.template
echo "[/var/log/ecs/ecs-agent.log]" >> /etc/awslogs/awslogs.template
echo "file = /var/log/ecs/ecs-agent.log*" >> /etc/awslogs/awslogs.template
echo "log_group_name = ${cloudwatch_log_group_name}" >> /etc/awslogs/awslogs.template
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.template

cp /etc/awslogs/awscli.template /etc/awslogs/awscli.conf
cp /etc/awslogs/awslogs.template /etc/awslogs/awslogs.conf
start ecs
service awslogs start
