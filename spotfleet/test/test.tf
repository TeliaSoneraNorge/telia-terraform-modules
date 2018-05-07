variable "subnets" {
  type = "list"

  default = [
    "abc",
    "def",
    "ghi",
  ]
}

variable "subnet_count" {
  default = "3"
}

variable "ami" {
  default = "ami-2d386654"
}

data "null_data_source" "spot" {
  count = "${var.subnet_count}"

  inputs = [{
    subnet_id     = "${element(var.subnets, count.index)}"
    ami           = "${var.ami}"
    instance_type = "m3.large"
  },
    {
      subnet_id     = "${element(var.subnets, count.index)}"
      ami           = "${var.ami}"
      instance_type = "t2.large"
    },
  ]
}

output "launch_specification" {
  value = "${data.null_data_source.spot.*.outputs}"
}
