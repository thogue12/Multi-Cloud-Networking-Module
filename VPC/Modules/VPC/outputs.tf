
output "vpc_id" {
  description = "VPC ID"
  value       = {for k, v in aws_vpc.this_vpc : k => v.id}
  
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = {for k, v in aws_vpc.this_vpc : k => v.cidr_block}
  
}

output "name" {
  description = "VPC ARN"
  value = var.name
}



# output "vpc_cidr" {
#   description = "VPC CIDR"
#   value = aws_vpc.this_vpc.cidr_block
# }

# output "vpc_id" {
#   description = "VPC ID"
#   value = aws_vpc.this_vpc.id
# }

# output "vpc_arn" {
#   description = "VPC ARN"
#   value = aws_vpc.this_vpc.arn
# }
