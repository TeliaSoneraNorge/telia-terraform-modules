locals {
  tags = "${merge(
  var.tags,
  map("Name", var.name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"
}

resource "aws_dynamodb_table" "this" {
  name           = "${var.local_environment}-${var.name}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  attribute = "${var.attribute}"

  ttl {
    attribute_name = "${var.ttl_attribute_name}"
    enabled        = "${var.ttl_enabled}"
  }

  server_side_encryption {
    "enabled" = "${var.server_side_encryption}"
  }

  tags = "${local.tags}"
}
