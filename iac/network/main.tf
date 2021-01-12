# -----------------------------------------------------------------------------
# Provider
# -----------------------------------------------------------------------------

provider "aws" {
  version             = "~> 3.0"
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
  profile             = var.aws_account_alias
}

