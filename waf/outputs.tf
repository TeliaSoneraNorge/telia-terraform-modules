output "instructions" {
  value = <<EOF
Use the following command to associate the Web ACL created by AWS CloudFormation with the public ALB:

aws waf-regional associate-web-acl --web-acl-id ${aws_cloudformation_stack.owasptop8.outputs["wafWebACL"]} --resource-arn ${data.terraform_remote_state.alb_public.this_alb_arn} --profile <your profile here>
EOF
}
