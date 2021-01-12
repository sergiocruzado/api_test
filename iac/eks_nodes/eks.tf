module "eks_managed_nodes" {
  source = "./modules/eks_managed_nodes"

  cluster_name = data.terraform_remote_state.eks_cluster.outputs.cluster_name
  cluster_id = data.terraform_remote_state.eks_cluster.outputs.cluster_id
  cluster_version = data.terraform_remote_state.eks_cluster.outputs.cluster_version
  cluster_ca = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  cluster_endpoint = data.aws_eks_cluster.this.endpoint

  nodes_role_arn = data.terraform_remote_state.eks_cluster.outputs.nodes_iam_role_arn
  
  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnets_id = data.terraform_remote_state.network.outputs.public_subnets_id

  tags = var.tags
}