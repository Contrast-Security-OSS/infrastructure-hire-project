output "public_subnet_arn" {
  description = "Public subnet ARN"
  value       = aws_subnet.public_subnet.arn
}

output "private_subnet_arn" {
  description = "Private subnet ARN"
  value       = aws_subnet.private_subnet.arn
}