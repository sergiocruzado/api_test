resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = { 
     mapRoles= <<YAML
- rolearn: ${aws_iam_role.eks_nodes.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
  - system:bootstrappers
  - system:nodes
YAML
  }
  
  depends_on = [ aws_eks_cluster.this ]
}