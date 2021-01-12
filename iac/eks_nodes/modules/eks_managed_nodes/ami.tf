# -----------------------------------------------------------------------------
# AWS AMI - EKS Nodes
# -----------------------------------------------------------------------------

data "aws_ami" "eks_nodes" {
  count = var.image_id == "" ? 1 : 0

  most_recent = true
  owners      = ["602401143452"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

