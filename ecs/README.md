## ECS

Set up an ECS cluster and register services with ease. The modules set up the following:

#### ecs/cluster

- Autoscaling group/launch configuration.
- Amazon ECS Optimized AMI with ECS and SSM agents running.
- A security group for the cluster (with all egress and ingress from the specified load balancers).
- CloudWatch log group for the ECS agent.
- IAM role/instance profile with appropriate privileges.

#### ecs/fargate

- Fargate version of `ecs/service` which creates containers in a VPC
- Creates the task definition with an attached task role.
- Sets up the target group and security group for the service.
- Usable with either an ALB or a NLB. 
- Sets up and enables logging for the task.
- Creates IAM roles for the ECS service.

#### ecs/microservice

- Wrapper for `ecs/service` which also...
- Assumes that a default listener has been created, and sets up a listener rule.

#### ecs/service

- Creates the task definition with an attached task role.
- Sets up the target group for the service.
- Usable with either an ALB or a NLB.
- Sets up and enables logging for the task.
- Creates IAM roles for the ECS service.

#### ecs/spotfleet

Cluster on a spotfleet - [detailed README](spotfleet/README.md)
- Ongoing Spotfleet request
- Amazon ECS Optimized AMI with ECS and SSM agents running.
- A security group for the cluster (with all egress and ingress from the specified load balancers).
- CloudWatch log group for the ECS agent.
- IAM role/instance profile with appropriate privileges.