output "this_security_group_id" {
  description = "The security group ID of Application Load Balancer"
  value       = "${var.alb_is_internal ? module.alb_security_group_internal.this_security_group_id : module.alb_security_group.this_security_group_id}"
}

output "this_alb_zone_id" {
  description = "The zone_id of the ALB to assist with creating DNS records"
  value       = "${module.alb.alb_zone_id}"
}

output "this_alb_dns_name" {
  description = "The DNS name of the ALB presumably to be used with a friendlier CNAME"
  value       = "${module.alb.alb_dns_name}"
}

output "this_alb_arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value       = "${module.alb.alb_arn}"
}

output "this_alb_arn_suffix" {
  description = "Suffix of ARN of the ALB. Useful for passing to cloudwatch Metric dimension."
  value       = "${module.alb.alb_arn_suffix}"
}

output "this_alb_target_group_arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value       = "${module.alb.target_group_arn}"
}

output "full_url" {
  description = "Full URL of the environment"
  value       = "https://${aws_route53_record.a.fqdn}"
}
