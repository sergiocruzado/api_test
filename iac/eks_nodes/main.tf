# -----------------------------------------------------------------------------
# Terraform
# -----------------------------------------------------------------------------

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks_cluster" {
  backend = "local"

  config = {
    path = "../eks_cluster/terraform.tfstate"
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

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks_cluster.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.terraform_remote_state.eks_cluster.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}