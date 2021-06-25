module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.24.0"

  identifier        = "${var.application}-${var.environment}-${var.identifier}-rds"
  apply_immediately = var.db_apply_immediately

  engine         = var.db_engine
  engine_version = var.db_engine_version
  major_engine_version = var.db_major_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  # auto scale capable factor
  max_allocated_storage = tostring(tonumber(var.db_allocated_storage) * 2)
  storage_encrypted     = true
  storage_type          = var.db_storage_type

  name     = var.db_name
  username = "admin"
  password = random_password.db_password.result
  port     = var.db_port

  iam_database_authentication_enabled = false

  multi_az               = var.db_multi_az
  vpc_security_group_ids = [aws_security_group.rds.id]

  maintenance_window           = var.db_maintenance_window
  backup_window                = var.db_backup_window
  backup_retention_period      = var.db_backup_retention_period
  performance_insights_enabled = var.db_performance_insights_enable
  snapshot_identifier          = var.db_snapshot_identifier


  # DB subnet group
  subnet_ids = var.db_subnets

  # DB parameter group
  family     = var.db_family
  parameters = var.db_parameters

  # DB option group
  option_group_name        = "${var.application}-${var.environment}-${var.identifier}-rds"
  option_group_description = "Option group for ${var.application}-${var.environment}-${var.identifier}-rds"

  # Database Deletion Protection
  deletion_protection = var.db_deletion_protection

  tags = merge(
    var.tags,
    map(
      "role", "db"
    )
  )
}

## SG ##
resource "aws_security_group" "rds" {
  name_prefix = "${var.application}-${var.environment}-${var.identifier}-rds-"
  description = "RDS connectivity for ${var.environment} ${var.identifier}"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    map(
      "Name", "${var.application}-${var.environment}-${var.identifier}-rds",
      "role", "db"
    )
  )
}

## SG Ingress ##
resource "aws_security_group_rule" "security_group_rules" {
  count                    = length(var.access_sgs) > 0 ? length(var.access_sgs) : 0
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = element(var.access_sgs, count.index)
  security_group_id        = aws_security_group.rds.id
}

resource "random_password" "db_password" {
  keepers = {
    rotator = var.db_rotate_password
  }
  length           = 16
  special          = true
  override_special = "_%$"
}

