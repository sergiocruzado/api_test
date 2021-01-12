module "eks_cluster" {
  source = "./modules/eks_cluster"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnets_id = data.terraform_remote_state.network.outputs.public_subnets_id

}
