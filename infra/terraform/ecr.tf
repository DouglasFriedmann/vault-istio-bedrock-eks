resource "aws_ecr_repository" "vibe_app" {
  name                 = "vibe-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = {
    Project = "vault-istio-bedrock-eks"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.vibe_app.repository_url
}
