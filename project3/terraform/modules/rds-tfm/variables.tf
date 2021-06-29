variable "region" {
  description = "AWS Region"
  type        = string
}

variable "account_id" {
  description = "AWS Account Id"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance - Must be set per env, in terraform.tfvars; or passed in at execution time"
  type        = string
}

variable "db_instance_class_map" {
  description = "A map for DB instance types to connection limits, memory, CPU, etc"
  type        = map

  default = {
    "db.t3.micro" = {
      memory = 1
    }
    "db.t3.small" = {
      memory = 2
    }
    "db.t3.medium" = {
      memory = 4
    }
    "db.t3.large" = {
      memory = 8
    }
    "db.t3.xlarge" = {
      memory = 16
    }
    "db.m5.large" = {
      memory = 8
    }
    "db.m5.xlarge" = {
      memory = 16
    }
    "db.m5.2xlarge" = {
      memory = 32
    }
    "db.r5.large" = {
      memory = 16
    }
    "db.r5.xlarge" = {
      memory = 32
    }
    "db.r5.2xlarge" = {
      memory = 64
    }
    "db.r5.4xlarge" = {
      memory = 128
    }
    "db.r5.8xlarge" = {
      memory = 256
    }
    "db.r5.12xlarge" = {
      memory = 384
    }
    "db.r4.large" = {
      memory = 15.25
    }
  }
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "db_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.23"
}

variable "db_snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  type        = string
  default     = null
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "25"
}

variable "db_create_monitoring_role" {
  description = "Enable/Disable RDS monitoring role creation"
  type        = bool
  default     = true
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in UTC. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Tue:07:00-Tue:07:30"
}

variable "db_apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "The days to retain backups for"
  type        = string
  default     = "7"
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "05:37-06:07"
}

variable "db_deletion_protection" {
  description = "Enable/Disable RDS deleteion protection"
  type        = bool
  default     = true
}

variable "db_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
}

variable "db_ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-2019"
}

variable "db_rotate_password" {
  description = "Modify this optional value to any string to rotate password."
  type        = string
  default     = "1"
}

variable "db_performance_insights_enable" {
  description = "Enable/Disable performance insights"
  type        = bool
  default     = false
}

variable "db_multi_az" {
  description = "Enable/Disable Multi AZ"
  type        = bool
  default     = true
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

variable "db_name" {
  description = "The schema name"
  type        = string
}

variable "db_storage_type" {
  description = "The schema name"
  type        = string
  default     = "gp2"
}

variable "application" {
  description = "Denotes the corresponding 'application' (e.g. 'Hub', Team Server', 'Ardy')"
  type        = string
}

variable "environment" {
  description = "Denotes the environment, a vertical slice of the infrastructure (e.g. 'staging', 'app') Specified per env, in the terraform.tfvars file"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
}

variable "db_subnets" {
  description = "A set of db subnets"
  type        = set(string)
}

variable "vpc_id" {
  description = "Identifier for the VPC network"
  type        = string
}

variable "access_sgs" {
  description = "Security groups to give access to"
  default     = []
  type        = list
}

variable "identifier" {
  description = "Extra identifier/name for the db"
  type        = string
}

variable "cloudwatch_alarm_enable" {
  description = "Enable cloudwatch alarms"
  default     = false
  type        = bool
}

variable "alarm_actions_minor" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  default     = []
  type        = list
}

variable "alarm_actions_major" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  default     = []
  type        = list
}

variable "swap_usage_threshold" {
  description = "Alarm threshold for the 'SwapUsage' alarm"
  default     = "256000000" // 256 MB
  type        = string
}

variable "freeable_memory_threshold" {
  description = "Alarm threshold for the 'FreeableMemory' alarm"
  default     = "128000000" // 128 MB
  type        = string
}

variable "anomaly_period" {
  description = "The number of seconds that make each evaluation period for anomaly detection."
  default     = "600"
  type        = string
}

variable "anomaly_band_width" {
  description = "The width of the anomaly band, default 2.  Higher numbers means less sensitive."
  default     = "2"
  type        = string
}
