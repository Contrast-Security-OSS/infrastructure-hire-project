resource "aws_ecr_repository" "ops_hire_app" {
  name = "ops-hire-app"
}

resource "aws_ecr_lifecycle_policy" "ops_hire_app_policy" {
  repository = aws_ecr_repository.ops_hire_app.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 10 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

output "repository_url" {
  description = "ECR repository URL of Docker image"
  value       = aws_ecr_repository.ops_hire_app.repository_url
}