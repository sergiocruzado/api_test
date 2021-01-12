# -----------------------------------------------------------------------------
# IAM Instance Profile - EKS Nodes 
# -----------------------------------------------------------------------------

resource "aws_iam_instance_profile" "eks_nodes" {
  name = format("ip-eks-managed-nodes-%s", var.cluster_name)
  role = aws_iam_role.eks_nodes.name
}

# -----------------------------------------------------------------------------
# IAM Role - EKS Cluster
# -----------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_service_role_eks" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = format("eks-cluster-%s", var.cluster_name)

  assume_role_policy = data.aws_iam_policy_document.assume_service_role_eks.json

  tags = var.tags
}


# -----------------------------------------------------------------------------
# IAM Role - EKS Nodes
# -----------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_service_role_eks_nodes" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_nodes" {
  name = format("eks-managed-nodes-%s", var.cluster_name)

  assume_role_policy = data.aws_iam_policy_document.assume_service_role_eks_nodes.json
}

# -----------------------------------------------------------------------------
# IAM Policy - EKS Cluster 
# -----------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}


resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}


# -----------------------------------------------------------------------------
# IAM Policy - EKS Nodes 
# -----------------------------------------------------------------------------


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}
