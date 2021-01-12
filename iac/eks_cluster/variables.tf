# -----------------------------------------------------------------------------
# Terraform
# -----------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_account_alias" {
  type        = string
  description = "AWS Region"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Region"
}

# -----------------------------------------------------------------------------
# Terraform
# -----------------------------------------------------------------------------

variable "tags" {
  type        = map
  description = "Additional tags"
  default     = {}
}

# -----------------------------------------------------------------------------
# EKS Cluster
# -----------------------------------------------------------------------------

variable "cluster_name" {
  type        = string
  description = "The nale of EKS"
}

variable "cluster_version" {
  type        = string
  description = "The version of k8s"
}

# -----------------------------------------------------------------------------
# ECR
# -----------------------------------------------------------------------------

variable "ecr_name" {
  type        = string
  description = "ECR repository name"
}