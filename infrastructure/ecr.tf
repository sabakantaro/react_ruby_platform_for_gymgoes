# Application ECR Repository
resource "aws_ecr_repository" "gym_platform_app" {
  name                 = "${var.r_prefix}-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.r_prefix}-app-ecr"
    Environment = var.environment
  }
}

resource "aws_ecr_lifecycle_policy" "gym_platform_app_lifecycle_policy" {
  repository = aws_ecr_repository.gym_platform_app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete images when count is more than 10"
        selection = {
          tagStatus     = "untagged"
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last 50 tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 50
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# Frontend ECR Repository (for React build)
resource "aws_ecr_repository" "gym_platform_frontend" {
  name                 = "${var.r_prefix}-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.r_prefix}-frontend-ecr"
    Environment = var.environment
  }
}
