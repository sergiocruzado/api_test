locals {
  module_tags = {
    module         = "network"
    module_version = "1.0.0"
    Name           = "test"
  }

  tags = merge(local.module_tags, var.tags)

}

data "aws_availability_zones" "all" {
  all_availability_zones = true
}