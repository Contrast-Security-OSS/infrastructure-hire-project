variable "aws_region" {
  default = "us-east-1"
}


# RDS
variable "db_deletion_protection" {
  description = "Enable/Disable RDS deletion protection"
  type        = bool
  default     = false
}
variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}
variable "db_maintenance_window" {
  description = "The window to perform maintenance in UTC."
  type        = string
  default     = "Tue:07:00-Tue:07:30"
}
variable "db_parameters" {
  description = "DB parameters"
  type        = list(map(string))
  default     = null
}
variable "db_performance_insights_enable" {
  description = "Enable/Disable performance insights"
  type        = bool
  default     = false
}



# VPC
variable "vpc_cidr" {
  description = "CIDR of the vpc"
  default     = "10.94.0.0/16"
  type        = string
}
variable "vpc_exclude_ids" {
  description = "The zone ids to exclude"
  type        = list(string)
  default     = []
}
variable "public_subnets" {
  default     = ["10.94.96.0/20", "10.94.112.0/20", "10.94.128.0/20"]
  description = "Public subnet CIDR layout"
  type        = list(string)
}
variable "private_subnets" {
  default     = ["10.94.0.0/20", "10.94.16.0/20", "10.94.32.0/20"]
  description = "Private subnet CIDR layout"
  type        = list(string)
}
variable "database_subnets" {
  default     = ["10.94.251.0/24", "10.94.252.0/24", "10.94.253.0/24"]
  description = "Database subnet CIDR layout"
  type        = list(string)
}


# Attributes
variable "application" {
  description = "Denotes the corresponding 'application'"
  type        = string
  default     = "project3"
}
variable "environment" {
  description = "Denotes the environment, a vertical slice of the infrastructure"
  type        = string
}
variable "identifier" {
  description = "Denotes the corresponding 'identifier'"
  type        = string
  default     = "001"
}

locals {
  common_tags = map(
    "application", var.application,
    "environment", var.environment,
  )
  environment = try(var.environment, "")
}

