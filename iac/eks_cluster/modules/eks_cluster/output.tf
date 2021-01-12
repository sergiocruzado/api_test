output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  value = aws_eks_cluster.this.version
}

output "certificate_authority" {
  value = aws_eks_cluster.this.certificate_authority
}

output "cluster_ca_data" {
  value = aws_eks_cluster.this.certificate_authority.0.data
}

output "cluster_iam_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "nodes_iam_role_arn" {
  value = aws_iam_role.eks_nodes.arn
}

output "cluster_sg_id" {
  value = aws_security_group.eks_cluster.arn
}