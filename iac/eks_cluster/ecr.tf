resource "aws_ecr_repository" "traefik2" {
  name = var.ecr_name
  tags = var.tags
}

