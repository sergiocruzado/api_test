locals {
  module_tags = {
    module         = "eks_cluster"
    module_version = "1.0.0"
  }
  
  tags = merge(local.module_tags, var.tags)

}
