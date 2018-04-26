# ecr-machine-role - Scoped roles for ECR for use with CI/CD

This module helps with setting up a Concourse CI machine role for the common artifacts account.
It is scoped by namespace (e.g. a team name), and each role will only have access to ECR repositories
under the specified namespace. The role is only assumable by the STS credentials lambda for Concourse, 
which is meant to assume this role and provide temporary credentials to Concourse teams via SSM Parameter store.
