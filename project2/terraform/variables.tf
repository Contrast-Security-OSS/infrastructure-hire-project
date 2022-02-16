variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "terraform-eks-demo"
  type    = string
}

variable  "inst_type" {
   default = "m5.large"
   type = string
}

variable "vpc_name" {
  default = "contrast"
  type = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "s3bucket" {
  default = "vancouver-canada"
  type = string
}

variable "cluster_name" {
   default = "contrast-cluster"
   type = string
}