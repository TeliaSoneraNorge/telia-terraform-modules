# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "id" {
  value = "${aws_ecs_cluster.main.id}"
}

output "role_name" {
  value = "${module.spotrequest.role_name}"
}

output "role_arn" {
  value = "${module.spotrequest.role_arn}"
}

output "role_id" {
  value = "${module.spotrequest.role_id}"
}

output "security_group_id" {
  value = "${module.spotrequest.security_group_id}"
}
