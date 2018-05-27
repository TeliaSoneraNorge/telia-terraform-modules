# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "id" {
  value = "${aws_rds_cluster.main.id}"
}

output "endpoint" {
  value = "${aws_rds_cluster.main.endpoint}"
}

output "connection_string" {
  value = "postgres://${var.username}:${var.password}@${aws_rds_cluster.main.endpoint}:${var.port}/main"
}

output "port" {
  value = "${aws_rds_cluster.main.port}"
}

output "database" {
  value = "${aws_rds_cluster.main.database_name}"
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
