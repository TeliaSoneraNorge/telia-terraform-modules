data "template_file" "launch_specs" {
  count = "${var.subnet_count}"
  template = "${file("${path.module}/specs.tpl")}"
  vars {
    subnet_id = "${element(var.subnets, count.index)}"
    ami = "${var.ami}"
    tags = "${merge(var.tags, map("Name", "${var.prefix}-spot-instance"))}"
  }
}