variable "tags" {
  type        = map
  description = "Additional tags for resources"
  default     = {}
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC Id to deply the resources"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list
  description = "The public subnet cidrs"
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list
  description = "The private subnet cidrs"
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}
