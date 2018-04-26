# Application Load Balancer (ALB)

This module creates AWS ALB in existing VPC subnets, EC2 security group and AWS Route53 records.

## Usage

### Internal ALB

`alb_is_internal = true`

  - Resides in private VPC subnets
  - Security group allows only CIDR of VPC and Direct Connect

### Internet-facing ALB

`alb_is_internal = false`

  - Resides in public VPC subnets
  - Security group allows access from any CIDR

## Dependencies

- This Terraform infrastructure module expects project variables which are usually defined in `main_providers.tf` in [each project in devops repository](https://github.com/TeliaSoneraNorge/devops/tree/master/terraform) and won't work without them.

- Terraform remote states:

  - vpc (eg, `eu-west-1/vpc/terraform.tfstate`)
  - vpc-peering (eg, `eu-west-1/vpc-peering/terraform.tfstate`)
  - s3-buckets (eg, `eu-west-1/s3-buckets/terraform.tfstate`)

- AWS ACM Certificate for specified `certificate_domain` should be `ISSUED`
