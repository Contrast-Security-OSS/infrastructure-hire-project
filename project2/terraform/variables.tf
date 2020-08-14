##############################################################
# Project variables
##############################################################

variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "project2"
}

variable "env" {
  default = "prod"
}

##############################################################
# Kubernetes variables
##############################################################
variable "image_version" {
  default = "v0.0.3"
}
