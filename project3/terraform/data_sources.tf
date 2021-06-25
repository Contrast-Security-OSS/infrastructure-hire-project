data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    subnet = "private"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = module.vpc.vpc_id
  tags = {
    subnet = "public"
  }
}

data "aws_subnet_ids" "database" {
  vpc_id = module.vpc.vpc_id
  tags = {
    subnet = "database"
  }
}


data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state            = "available"
  exclude_zone_ids = var.vpc_exclude_ids
}

