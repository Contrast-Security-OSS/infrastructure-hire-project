# Provider
aws_region = "us-east-1"


# RDS
db_instance_class = "db.t3.medium"
db_parameters = [
  {
    name  = "log_queries_not_using_indexes"
    value = "1"
  },
  {
    name  = "slow_query_log"
    value = "0"
  },
  {
    name  = "innodb_buffer_pool_size"
    value = "536870912"
  },
  {
    name  = "innodb_log_buffer_size"
    value = "262144"
  },
  {
    name  = "innodb_log_file_size"
    value = "2097152"
  }
]


# VPC


# Attributes
environment = "production"
