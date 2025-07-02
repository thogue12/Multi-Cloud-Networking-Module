
# #tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
# <<<<<<< HEAD
# resource "aws_vpc" "acceptor_vpc" {  
#   cidr_block       = var.acceptor_cidr
# =======
# resource "aws_vpc" "destination_vpc" {  
#   cidr_block       = var.dest_cidr
# >>>>>>> aab567e (changed a few things)
#   instance_tenancy = "default"

#   enable_dns_support = true
#   enable_dns_hostnames = true
#   provider = aws.us-west
  

#   tags = {
#     Name = var.acceptor_vpc_name
#     Environment = var.environment
#   }
# }

# ### Elastic IP for NAT Gateway ###
# resource "aws_eip" "acceptor_nat_eip" {
#   provider = aws.us-west

#   tags = {
#     Name = "${var.acceptor_vpc_name}-nat-eip"
#   }

#   depends_on = [ aws_vpc.acceptor_vpc ]
# }
# resource "aws_nat_gateway" "acceptor_nat_gw" {
#   provider = aws.us-west
#   allocation_id = aws_eip.acceptor_nat_eip.id
#   subnet_id     = aws_subnet.acceptor_public_subnet.id

#   tags = {
#     Name = "${var.acceptor_vpc_name}-nat-gateway"
#   }

#   depends_on = [ aws_eip.acceptor_nat_eip ]
# }

# ### Internet Gateway ###
# resource "aws_internet_gateway" "acceptor_igw" {
#   provider = aws.us-west
#   vpc_id   = aws_vpc.acceptor_vpc.id

#   depends_on = [ aws_vpc.acceptor_vpc ]

#   tags = {
#     Name = "${var.acceptor_vpc_name}-igw"
#   }
# <<<<<<< HEAD
# }
# =======
# }



# >>>>>>> main
