#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "vpc_a" {  
  cidr_block       = var.vpc_a_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  

  tags = {
    Name = var.vpc_a_name
  }
}
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "vpc_b" {  
  cidr_block       = var.vpc_b_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
 
  

  tags = {
    Name = var.vpc_b_name
  }
}
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "vpc_c" {  
  cidr_block       = var.vpc_c_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  

  tags = {
    Name = var.vpc_c_name
  }
}
