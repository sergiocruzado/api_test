variable "image_id" {
  type        = string
  description = "The AMI Id for EKS Nodes"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "The AMI Id for EKS Nodes"
}

variable "cluster_version" {
  type        = string
  description = "The version of k8s"
}

variable "cluster_id" {
  type        = string
  description = "The AMI Id for EKS Nodes"
}

variable "cluster_endpoint" {
  type        = string
  description = "The AMI Id for EKS Nodes"
}

variable "cluster_ca" {
  type        = string
  description = "The AMI Id for EKS Nodes"
}
variable "max_pods" {
  type        = string
  description = "The AMI Id for EKS Nodes"
  default = 5
}
variable "vpc_id" {
  type        = string
  description = "The VPC Id to deply the resources"
}

variable "subnets_id" {
  type        = list(string)
  description = "List of subnets ID"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for resources"
  default     = {}
}

variable "instance_type" {
  type        = string
  description = "The instance type for EKS Nodes"
  default     = "t3.medium"
}

variable "key_pair_name" {
  type        = string
  description = "The key pair name for accessing by SSH"
  default     = ""
}

variable "root_volume_size" {
  type        = string
  description = "The root volume size"
  default     = "20"
}

variable "volume_type" {
  type        = string
  description = "The root volume size"
  default     = "gp2"
}

variable "volume_encryption" {
  type        = bool
  description = "If use encription"
  default     = false
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key Id"
  default     = ""
}

variable "nodes_role_arn" {
  type        = string
  description = "The Role ARN for EKS Nodes"
  default     = ""
}


variable "allow_all_egress" {
  type    = bool
  default = true
}

variable "allow_all_ingress" {
  type    = bool
  default = true
}

variable "min_capacity_size" {
  type        = number
  description = "The minimun nodes"
  default     = 2
}

variable "max_capacity_size" {
  type        = number
  description = "The maximun nodes"
  default     = 3
}