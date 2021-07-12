module the_app_db {
  source = "./modules/rds-tfm"

  identifier = "the-app-db"
  db_name    = "the_app_db"

  account_id                     = data.aws_caller_identity.current.account_id
  application                    = var.application
  db_deletion_protection         = var.db_deletion_protection
  db_instance_class              = var.db_instance_class
  db_maintenance_window          = var.db_maintenance_window
  db_parameters                  = var.db_parameters
  db_performance_insights_enable = var.db_performance_insights_enable
  db_subnets                     = module.vpc.database_subnets
  environment                    = var.environment
  region                         = var.aws_region
  tags                           = local.common_tags
  vpc_id                         = module.vpc.vpc_id
}

