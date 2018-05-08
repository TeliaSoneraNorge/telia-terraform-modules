# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "id" {
  value = "${aws_ecs_cluster.main.id}"
}

output "role_name" {
  value = "${aws_iam_role.spotfleet.name}"
}

output "role_arn" {
  value = "${aws_iam_role.spotfleet.arn}"
}

output "role_id" {
  value = "${aws_iam_role.spotfleet.id}"
}

output "security_group_id" {
  value = "${aws_security_group.ecs-instances.id}"
}
