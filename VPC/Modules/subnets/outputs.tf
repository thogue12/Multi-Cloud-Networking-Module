output "public_subnets_cidr_blocks" {
  description = "values of public subnets CIDR blocks"
  value       = aws_subnet.public_subnets[*].cidr_block
}

output "private_subnets_cidr_blocks" {
  description = "values of private subnets CIDR blocks"
  value       = aws_subnet.private_subnets[*].cidr_block
}

output "create_public_subnets" {
  description = "value of create_public_subnets local variable"
  value       = local.create_public_subnets
}

output "create_private_subnets" {
  description = "value of create_private_subnets local variable"
  value       = local.create_private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public_subnets[*].arn
}
