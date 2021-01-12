# -----------------------------------------------------------------------------
# Terraform
# -----------------------------------------------------------------------------

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }
}


# -----------------------------------------------------------------------------
# Provider
# -----------------------------------------------------------------------------

provider "aws" {
  version             = "~> 3.0"
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
  profile             = var.aws_account_alias
}

# -----------------------------------------------------------------------------
# K8s
# -----------------------------------------------------------------------------

data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}
