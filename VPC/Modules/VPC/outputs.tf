output "vpc_cidr" {
  description = "VPC CIDR"
  value = aws_vpc.this_vpc.cidr_block
}

output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.this_vpc.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value = aws_vpc.this_vpc.arn
}