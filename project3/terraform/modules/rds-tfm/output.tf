output "arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.this_db_instance_arn
}
output "security_group_id" {
  description = "ID of the RDS Security Group"
  value       = aws_security_group.rds.id
}
output "id" {
  description = "ID of the RDS instance"
  value       = module.rds.this_db_instance_id
}