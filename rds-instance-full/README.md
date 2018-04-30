# Relational Database Service (RDS) using Postgres

This module creates AWS RDS in private subnet of an existing VPC and security group. There are these options:

- RDS instance from a snapshot (optionally)
- Create a random password (optionally) and stores DB credential into SSM Parameter Store
- Security group allows only CIDR of VPC

## Usage

### Create RDS instance from snapshot

`manual_db_snapshot_identifier = "snapshot-id"`

## Dependencies

- This Terraform infrastructure module expects project variables which are usually defined in `main_providers.tf` in [each project in devops repository](https://github.com/TeliaSoneraNorge/devops/tree/master/terraform) and won't work without them.

- Terraform remote states:

  - vpc (eg, `eu-west-1/vpc/terraform.tfstate`)
