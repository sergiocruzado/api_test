locals {
  module_tags = {
    module         = "eks_managed_nodes"
    module_version = "1.0.0"
  }

  tags = merge(local.module_tags, var.tags)

  image_id = coalesce(var.image_id, join("", data.aws_ami.eks_nodes.*.id))

}
