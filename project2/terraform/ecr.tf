resource "aws_ecr_repository" "vulnerability_reporting" {
  name = "${var.project}-vulnerability-report"

  tags = {
    name      = "${var.project}-vulnerability-reporting"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}
