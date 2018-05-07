locals {
  spotfleet_definition = [
    {
      ami               = "${var.ami}"
      instance_type     = "c3.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c3.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c3.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.medium"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.medium"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.medium"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c4.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c4.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c4.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r3.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r3.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r3.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m4.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m4.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m4.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r4.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r4.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "r4.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c5.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c5.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "c5.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m5.large"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m5.large"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m5.large"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 2

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.medium"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.medium"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "m3.medium"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.small"
      subnet_id         = "${var.subnets[0]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.small"
      subnet_id         = "${var.subnets[1]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
    {
      ami               = "${var.ami}"
      instance_type     = "t2.small"
      subnet_id         = "${var.subnets[2]}"
      weighted_capacity = 1

      tags = {
        "Name" = "${var.prefix}-spot-instance"
      }
    },
  ]
}
