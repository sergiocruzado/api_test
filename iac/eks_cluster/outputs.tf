# -----------------------------------------------------------------------------
# EKS
# -----------------------------------------------------------------------------

output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "cluster_id" {
  value = module.eks_cluster.cluster_id
}

output "cluster_version" {
  value = var.cluster_version
}

output "nodes_iam_role_arn" {
  value = module.eks_cluster.nodes_iam_role_arn
}

# -----------------------------------------------------------------------------
# K8s
# -----------------------------------------------------------------------------

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks_cluster.cluster_endpoint}
    certificate-authority-data: ${module.eks_cluster.cluster_ca_data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "kubeconfig" {
  value = local.kubeconfig
}