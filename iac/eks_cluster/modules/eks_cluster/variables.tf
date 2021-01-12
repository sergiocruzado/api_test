variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
}

variable "cluster_version" {
  type        = string
  description = "The version of k8s"
}

variable "cluster_enabled_log_types" {
  type        = list
  description = "A list of the desired control plane logging to enable. Possible values ->\"api\",\"audit\",\"authenticator\",\"controllerManager\",\"scheduler\""
  default     = ["api", "audit", "authenticator"]
}

variable "tags" {
  type        = map
  description = "Additional tags for resources"
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "The VPC Id to deply the resources"
}

variable "subnets_id" {
  type        = list(string)
  description = "List of subnets ID"
}

variable "enable_private_access" {
  type    = bool  
  default = false
}

variable "enable_public_access" {
  type    = bool
  default = true
}

variable "allow_all_egress" {
  type    = bool
  default = true
}

variable "allow_all_ingress" {
  type    = bool
  default = true
}