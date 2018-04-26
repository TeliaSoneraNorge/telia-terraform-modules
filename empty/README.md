# This is an empty directory without any Terraform code

So, don't put anything meaningful here.

## But why????

The main reason is that in order to use before&after hooks in Terragrunt (eg, `terragrunt init`) the Terraform configuration code should be always sourced from Terraform modules. And this module acts as a simple module wrapper.
