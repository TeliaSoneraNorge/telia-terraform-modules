output "public_route53_zone_name" {
  description = "The name of public zone"
  value       = "${element(concat(aws_route53_zone.public.*.name, list("")), 0)}"
}

output "public_route53_zone_id" {
  description = "The Hosted Zone ID of public zone"
  value       = "${element(concat(aws_route53_zone.public.*.zone_id, list("")), 0)}"
}

output "public_route53_zone_name_servers" {
  description = "A list of name servers in associated (or default) delegation set of public zone"
  value       = "${flatten(aws_route53_zone.public.*.name_servers)}"
}

output "private_route53_zone_name" {
  description = "The name of private zone"
  value       = "${element(concat(aws_route53_zone.private.*.name, list("")), 0)}"
}

output "private_route53_zone_id" {
  description = "The Hosted Zone ID of private zone"
  value       = "${element(concat(aws_route53_zone.private.*.zone_id, list("")), 0)}"
}

output "private_route53_zone_name_servers" {
  description = "A list of name servers in associated (or default) delegation set of private zone"
  value       = "${flatten(aws_route53_zone.private.*.name_servers)}"
}
