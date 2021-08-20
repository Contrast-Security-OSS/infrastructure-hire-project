output "public_subnet_arn" {
  description = "Public subnet ARN"
  value       = aws_subnet.public_subnets.*.arn
}

output "private_subnet_arn" {
  description = "Private subnet ARN"
  value       = aws_subnet.private_subnets.*.arn
}

output "alb_hostname" {
  value = aws_alb.main_alb.dns_name
}