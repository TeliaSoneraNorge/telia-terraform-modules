# -------------------------------------------------------------------------------
# Resources
# -------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

resource "aws_rds_cluster" "main" {
  cluster_identifier           = "${var.prefix}-cluster"
  database_name                = "${var.db_name}"
  master_username              = "${var.username}"
  master_password              = "${var.password}"
  port                         = "${var.port}"
  engine                       = "${var.engine}"
  backup_retention_period      = 7
  preferred_backup_window      = "02:00-03:00"
  preferred_maintenance_window = "wed:04:00-wed:04:30"
  snapshot_identifier          = "${var.snapshot_identifier}"
  skip_final_snapshot          = "${var.skip_final_snapshot}"
  vpc_security_group_ids       = ["${aws_security_group.main.id}"]

  # NOTE: This is duplicated because subnet_group does not return the name.
  db_subnet_group_name = "${var.prefix}-subnet-group"

  tags = "${merge(var.tags, map("Name", "${var.prefix}-cluster"))}"
}

resource "aws_rds_cluster_instance" "main" {
  count                = "${var.instance_count}"
  identifier           = "${var.prefix}-instance-${count.index + 1}"
  cluster_identifier   = "${aws_rds_cluster.main.id}"
  instance_class       = "${var.instance_type}"
  engine               = "${var.engine}"
  db_subnet_group_name = "${aws_db_subnet_group.main.name}"
  publicly_accessible  = "${var.public_access}"

  tags = "${merge(var.tags, map("Name", "${var.prefix}-instance-${count.index + 1}"))}"
}

resource "aws_db_subnet_group" "main" {
  name        = "${var.prefix}-subnet-group"
  description = "Terraformed subnet group."
  subnet_ids  = ["${var.subnet_ids}"]

  tags = "${merge(var.tags, map("Name", "${var.prefix}-subnet-group"))}"
}

resource "aws_security_group" "main" {
  name        = "${var.prefix}-sg"
  description = "Terraformed security group."
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", "${var.prefix}-sg"))}"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.main.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
