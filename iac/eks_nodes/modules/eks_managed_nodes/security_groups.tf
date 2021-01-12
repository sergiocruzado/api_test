resource "aws_security_group" "eks_nodes" {
  name        = format("eks_nodes_%s", var.cluster_name)
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, map(
    "Name", format("eks_cluster_%s", var.cluster_name)
  ))
}

resource "aws_security_group_rule" "all_egress" {
  count             = var.allow_all_egress ? 1 : 0
  type              = "egress"
  security_group_id = aws_security_group.eks_nodes.id

  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_ingress" {
  count             = var.allow_all_ingress ? 1 : 0
  type              = "ingress"
  security_group_id = aws_security_group.eks_nodes.id

  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}