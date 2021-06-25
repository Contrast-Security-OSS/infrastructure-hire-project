# Provider
aws_region = "us-east-1"

# Main
aws_backup_rds_enabled         = true
db_instance_class              = "db.t3.medium"
db_performance_insights_enable = false
vpc_dns_zone                   = "contrastsecurity.com"
tfp_version_environment        = "prod"

# RDS
db_parameters = [
    {
      name  = "log_bin_trust_function_creators"
      value = "1"
    },
    {
      name  = "log_queries_not_using_indexes"
      value = "1"
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
      value        = "1"
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
  ]


# VPC
database_subnets        = ["10.25.201.0/24", "10.25.202.0/24", "10.25.203.0/24"]
elasticache_subnets     = ["10.25.151.0/24", "10.25.152.0/24", "10.25.153.0/24"]
private_subnets         = ["10.25.96.0/20", "10.25.112.0/20", "10.25.128.0/20"]
public_subnets          = ["10.25.0.0/20", "10.25.16.0/20", "10.25.32.0/20"]
vpc_cidr                = "10.25.0.0/16"
vpc_dns_zone            = "opstftest.contsec.com"


# Attributes
environment = "production"

