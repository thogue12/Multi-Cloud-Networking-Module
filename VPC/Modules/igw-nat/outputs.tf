output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this_igw[0].id
}

output "nat_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this_nat[0].id
}