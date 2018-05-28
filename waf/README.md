# AWS WAF Setup 

This Terraform configuration creates AWS CloudFormation stack from the template based on [this document](https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/)

The WAF needs to be configured manually afterwards. The main task being: IP filtering and URL White Lists.

The best way to customize the OWASP rules is to visit the [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home)

Once WAF Web ACL is created it has to be associated with the ALB as specified in the Terraform output.


