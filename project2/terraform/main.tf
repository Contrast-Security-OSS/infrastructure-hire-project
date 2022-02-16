provider "aws" {
  region = var.region
  shared_credentials_file = "terraform/.aws/credentials"
  profile                 = "AWS_Profile"
}

data "aws_eks_cluster" "cluster1" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster1" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = 1.21
  subnet_ids      = module.vpc.public_subnets
  enable_irsa = true

  vpc_id = module.vpc.vpc_id

  self_managed_node_groups = {
    one = {
      name                          = "worker-group-1"
      instance_type                 = var.inst_type
      asg_desired_capacity          = 2
    }
}
}

