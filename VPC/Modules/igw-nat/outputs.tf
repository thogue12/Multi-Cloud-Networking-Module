###

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = {for k, v in aws_internet_gateway.this_igw : k => v.id}
  
}

output "nat_id" {
  description = "The ID of the NAT Gateway"
  value       = {for k, v in aws_nat_gateway.this_nat : k => v.id}
  
}



output "allocation_id" {
  description = "The ID of the EIP"
  value       = {for k, v in aws_eip.this_eip : k => v.id}
}













# output "igw_id" {
#   description = "The ID of the Internet Gateway"
#   value       = aws_internet_gateway.this_igw[0].id
# }

# output "nat_id" {
#   description = "The ID of the NAT Gateway"
#   value       = aws_nat_gateway.this_nat[0].id
# }