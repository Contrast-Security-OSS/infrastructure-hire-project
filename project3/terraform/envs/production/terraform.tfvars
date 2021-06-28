# Provider
aws_region = "us-east-1"

# Main
db_instance_class = "db.t3.medium"

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


# Attributes
environment = "production"

