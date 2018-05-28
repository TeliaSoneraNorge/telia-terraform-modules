data "terraform_remote_state" "alb_public" {
  backend = "s3"

  config {
    region = "${var.terraform_state_region}"
    bucket = "${var.terraform_state_bucket}"
    key    = "${var.aws_region}/alb-public/terraform.tfstate"
  }
}

locals {
  tags = "${merge(
  var.tags,
  map("Name", var.global_name),
  map("Project", var.global_project),
  map("Environment", var.local_environment)
  )}"
}

resource "aws_cloudformation_stack" "owasptop8" {
  name          = "modified-owasp-top10-waf-stack"
  template_body = "${file("cloudformation/owasptop10.yml")}"

  tags = "${local.tags}"
}
