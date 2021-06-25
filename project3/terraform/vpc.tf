locals {
  eks_cluster_name = "${var.application}-${var.environment}-${var.identifier}"
}

module "vpc" {
  source              = "./modules/aws_vpc-tfm"
  name                = "${var.application}-${var.environment}"
  cidr                = var.vpc_cidr
  azs                 = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  database_subnets    = var.database_subnets

  public_subnet_tags = {
    subnet                                            = "public"
  }
  private_subnet_tags = {
    subnet                                            = "private"
  }
  database_subnet_tags = {
    subnet = "database"
  }

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  create_database_subnet_group           = false
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags
}


