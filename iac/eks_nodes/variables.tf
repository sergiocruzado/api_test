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
