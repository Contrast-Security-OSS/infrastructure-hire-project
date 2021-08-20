# Create ECR repository to store docker images
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

# Create Role in order to allow use private docker images from ECR
resource "aws_iam_role" "ecs_tasks_role" {
  name = "EcsTasksRole"

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

output "repository_url" {
  description = "ECR repository URL of Docker image"
  value       = aws_ecr_repository.ops_hire_app.repository_url
}

output "ecs_tasks_role_arn" {
  description = "Role for ECR permissions"
  value       = aws_iam_role.ecs_tasks_role.arn
}
