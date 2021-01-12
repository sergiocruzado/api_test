# -----------------------------------------------------------------------------
# EKS Nodes - Userdata
# -----------------------------------------------------------------------------

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/amazon-eks-nodegroup.yaml


data "template_file" "eks_nodes_userdata" {
  template = file(format("%s/userdata/node_userdata.tpl", path.module))

  vars = {
    eks_cluster_id       = var.cluster_id
    eks_cluster_endpoint = var.cluster_endpoint
    b64_cluster_ca       = var.cluster_ca
    max_pods             = var.max_pods
  }
}

# -----------------------------------------------------------------------------
# EKS Nodes - Launch Template
# -----------------------------------------------------------------------------

resource "aws_launch_template" "eks_nodes" {
  name_prefix = format("lt-eks-nodes-%s-", var.cluster_name)

  instance_type = var.instance_type

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.root_volume_size
      volume_type = var.volume_type
      encrypted   = var.volume_encryption
      kms_key_id  = var.kms_key_id

      delete_on_termination = true
    }
  }

  image_id = local.image_id

  user_data = base64encode(data.template_file.eks_nodes_userdata.rendered)

  vpc_security_group_ids = [aws_security_group.eks_nodes.id]

  tag_specifications {
    resource_type = "volume"
    tags          = merge(local.tags, map("Name", format("lt-eks-nodes-%s", var.cluster_name)))
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.tags, map("Name", format("lt-eks-nodes-%s", var.cluster_name)))
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.tags, map("Name", format("lt-eks-nodes-%s", var.cluster_name)))
}

# -----------------------------------------------------------------------------
# EKS Nodes - Managed
# -----------------------------------------------------------------------------

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = format("eks-managed-nodes-%s",var.cluster_name)
  node_role_arn   = var.nodes_role_arn
  subnet_ids      = var.subnets_id

  launch_template {
    id = aws_launch_template.eks_nodes.id
    version = "$Latest"
  } 

  scaling_config {
    desired_size = var.min_capacity_size
    max_size     = var.max_capacity_size
    min_size     = var.min_capacity_size
  }

  tags  = local.tags

}
