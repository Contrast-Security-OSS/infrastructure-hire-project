
data "aws_availability_zones" "available" {
  state            = "available"
  exclude_zone_ids = var.vpc_exclude_ids
}

data "aws_caller_identity" "current" {}

