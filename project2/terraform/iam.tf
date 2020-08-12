##############################################################
#  IAM user for github actions
##############################################################
# User
resource "aws_iam_user" "github_actions" {
  name = "github-actions"

  tags = {
    name      = "${var.project}-vulnerability-reporting"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}

# User policy
resource "aws_iam_user_policy_attachment" "github_actions" {
  user       = aws_iam_user.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# Access keys
resource "aws_iam_access_key" "github_actions" {
  user    = aws_iam_user.github_actions.name
}

# SSM parameters to store access keys
resource "aws_ssm_parameter" "github_access_key" {
  name        = "/${var.project}/github_access_key"
  description = "github actions access key for ${var.project}"
  type        = "SecureString"
  key_id      = aws_kms_key.infra.arn
  value       = aws_iam_access_key.github_actions.id

  tags = {
    name      = "${var.project}-vulnerability-reporting"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}

resource "aws_ssm_parameter" "github_access_secret" {
  name        = "/${var.project}/github_access_secret"
  description = "github actions secret key for ${var.project}"
  type        = "SecureString"
  key_id      = aws_kms_key.infra.arn
  value       = aws_iam_access_key.github_actions.secret

  tags = {
    name      = "${var.project}-vulnerability-reporting"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}
