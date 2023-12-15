# Provider
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
  default = [
    {
      name  = "log_bin_trust_function_creators"
      value = "1"
    },
    {
      name  = "log_queries_not_using_indexes"
      value = "0"
    },
    {
      name  = "long_query_time"
      value = "3"
    },
    {
      name  = "max_allowed_packet"
      value = "33554432"
    },
    {
      name         = "performance_schema"
      value        = "0"
      apply_method = "pending-reboot"
    },
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "log_output"
      value = "FILE"
    },
    {
      name  = "innodb_sort_buffer_size"
      value = "262144"
    },
    {
      name  = "sort_buffer_size"
      value = "20971520"
    },
    {
      name  = "sync_binlog"
      value = "1"
    },
    {
      name  = "binlog_format"
      value = "STATEMENT"
    },
    {
      name  = "transaction_isolation"
      value = "READ-COMMITTED"
    },
    {
      name  = "binlog_checksum"
      value = "NONE"
    },
    {
      name  = "skip_name_resolve"
      value = "OFF"
    }
  ]
}
variable "db_performance_insights_enable" {
  description = "Enable/Disable performance insights"
  type        = bool
  default     = false
}


# VPC
variable "database_subnets" {
  default     = ["10.94.251.0/24", "10.94.252.0/24", "10.94.253.0/24"]
  description = "Database subnet CIDR layout"
  type        = list(string)
}
variable "private_subnets" {
  default     = ["10.94.0.0/20", "10.94.16.0/20", "10.94.32.0/20"]
  description = "Private subnet CIDR layout"
  type        = list(string)
}
variable "public_subnets" {
  default     = ["10.94.96.0/20", "10.94.112.0/20", "10.94.128.0/20"]
  description = "Public subnet CIDR layout"
  type        = list(string)
}
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
}
