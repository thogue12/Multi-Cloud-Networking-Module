output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.this_vpc[0].id
}

output "vpc_cidr" {
  description = "VPC CIDR"  
  value = aws_vpc.this_vpc[0].cidr_block
}
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this_igw[0].id
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = aws_internet_gateway.this_igw[0].arn
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public_subnets[*].arn
}
output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public_subnets[*].cidr_block)
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private_subnets[*].cidr_block)
}