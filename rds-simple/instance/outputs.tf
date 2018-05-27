# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "id" {
  value = "${aws_db_instance.main.id}"
}

output "arn" {
  value = "${aws_db_instance.main.arn}"
}

output "address" {
  value = "${aws_db_instance.main.address}"
}

output "endpoint" {
  value = "${aws_db_instance.main.endpoint}"
}

output "connection_string" {
  value = "postgres://${var.username}:${var.password}@${aws_db_instance.main.address}:${var.port}/main"
}

output "port" {
  value = "${aws_db_instance.main.port}"
}

output "database" {
  value = "${aws_db_instance.main.name}"
}

output "security_group_id" {
  value = "${aws_security_group.main.id}"
}

output "subnet_group_id" {
  value = "${aws_db_subnet_group.main.id}"
}

output "subnet_group_arn" {
  value = "${aws_db_subnet_group.main.arn}"
}
