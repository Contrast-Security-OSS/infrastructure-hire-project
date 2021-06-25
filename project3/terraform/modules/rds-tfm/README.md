## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| rds | terraform-aws-modules/rds/aws | 2.24.0 |

## Resources

| Name |
|------|
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) |
| [aws_cloudwatch_log_subscription_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) |
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |
| [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_sgs | Security groups to give access to | `list` | `[]` | no |
| account\_id | AWS Account Id | `string` | n/a | yes |
| application | Denotes the corresponding 'application' (e.g. 'Hub', Team Server', 'Ardy') | `string` | n/a | yes |
| db\_allocated\_storage | The allocated storage in gigabytes | `string` | `"25"` | no |
| db\_apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| db\_backup\_retention\_period | The days to retain backups for | `string` | `"7"` | no |
| db\_backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `"05:37-06:07"` | no |
| db\_ca\_cert\_identifier | Specifies the identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| db\_create\_monitoring\_role | Enable/Disable RDS monitoring role creation | `bool` | `true` | no |
| db\_deletion\_protection | Enable/Disable RDS deleteion protection | `bool` | `true` | no |
| db\_engine | The database engine to use | `string` | `"mysql"` | no |
| db\_engine\_version | The engine version to use | `string` | `"8.0.20"` | no |
| db\_family | The family of the DB parameter group | `string` | `"mysql8.0"` | no |
| db\_instance\_class | The instance type of the RDS instance - Must be set per env, in terraform.tfvars; or passed in at execution time | `string` | n/a | yes |
| db\_maintenance\_window | The window to perform maintenance in UTC. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `"Tue:07:00-Tue:07:30"` | no |
| db\_major\_engine\_version | Specifies the major version of the engine that this option group should be associated with | `string` | `"8.0"` | no |
| db\_multi\_az | Enable/Disable Multi AZ | `bool` | `true` | no |
| db\_name | The schema name | `string` | n/a | yes |
| db\_parameters | DB parameters | `list(map(string))` | <pre>[<br>  {<br>    "name": "log_bin_trust_function_creators",<br>    "value": "1"<br>  },<br>  {<br>    "name": "log_queries_not_using_indexes",<br>    "value": "1"<br>  },<br>  {<br>    "name": "long_query_time",<br>    "value": "3"<br>  },<br>  {<br>    "name": "max_allowed_packet",<br>    "value": "33554432"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "performance_schema",<br>    "value": "1"<br>  },<br>  {<br>    "name": "slow_query_log",<br>    "value": "1"<br>  },<br>  {<br>    "name": "log_output",<br>    "value": "FILE"<br>  }<br>]</pre> | no |
| db\_performance\_insights\_enable | Enable/Disable performance insights | `bool` | `false` | no |
| db\_port | The port on which the DB accepts connections | `string` | `"3306"` | no |
| db\_rotate\_password | Modify this optional value to any string to rotate password. | `string` | `"1"` | no |
| db\_snapshot\_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `null` | no |
| db\_storage\_type | The schema name | `string` | `"gp2"` | no |
| db\_subnets | A set of db subnets | `set(string)` | n/a | yes |
| environment | Denotes the environment, a vertical slice of the infrastructure (e.g. 'staging', 'app') Specified per env, in the terraform.tfvars file | `string` | n/a | yes |
| environment\_modifier | A string to allow for unique names for testing purposes | `string` | n/a | yes |
| identifier | Extra identifier/name for the db | `string` | n/a | yes |
| internal\_zone\_id | VPCs internal route53 zone id | `string` | n/a | yes |
| region | AWS Region | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map` | n/a | yes |
| vpc\_id | Identifier for the VPC network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | ID of the RDS Security Group |
