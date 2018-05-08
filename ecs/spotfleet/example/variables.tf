# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "prefix" {
  default = "spotfleet-example"
}

provider "aws" {
  region = "eu-west-1"
}

variable "tags" {
  type = "map"

  default = {
    terraform   = "true"
    environment = "dev"
    test        = "true"
  }
}
