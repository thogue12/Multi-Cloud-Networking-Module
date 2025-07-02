
###
output "public_subnets_cidr_blocks" {
  description = "values of public subnets CIDR blocks"
  value       = {for k, v in aws_subnet.public_subnets : k => v.cidr_block}
}


output "private_subnets_cidr_blocks" {
  description = "values of private subnets CIDR blocks"
  value       = {for k, v in aws_subnet.private_subnets : k => v.cidr_block}
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = {for k, v in aws_subnet.public_subnets : k => v.id}
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = {for k, v in aws_subnet.private_subnets : k => v.id}
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = {for k, v in aws_subnet.public_subnets : k => v.arn}
}

output "private_subnets_arns" {
  description = "List of ARNs of private subnets"
  value       = {for k, v in aws_subnet.private_subnets : k => v.arn}
}
