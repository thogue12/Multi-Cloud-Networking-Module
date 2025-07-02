# ### Subnets for Source VPC ###
# ### Public Subnet ###
# resource "aws_subnet" "requester_public_subnet" {
#   provider = aws.us-east
#   vpc_id     = aws_vpc.requester_vpc.id
#   cidr_block = var.requester_vpc_pub_sub_cidr
#   availability_zone = var.requester_subnet1_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch  #tfsec:ignore:aws-ec2-no-public-ip-subnet

#   tags = {
#     Name = "${var.requester_vpc_name}-public-subnet"
#   }
# }

# ## Private Subnets ##
# resource "aws_subnet" "requester_subnet1" {
#   provider = aws.us-east
#   vpc_id     = aws_vpc.requester_vpc.id
#   cidr_block = var.requester_subnet1_cidr
#   availability_zone = var.requester_subnet1_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch 

#   tags = {
#     Name = var.requester_subnet1_name
#   }
# }


# resource "aws_subnet" "requester_subnet2" {
#   provider = aws.us-east
#   vpc_id     = aws_vpc.requester_vpc.id
#   cidr_block = var.requester_subnet2_cidr
#   availability_zone = var.requester_subnet2_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch 

#   tags = {
#     Name = var.requester_subnet2_name
#   }
# }

# ### Subnets for Destination VPC ###
# resource "aws_subnet" "acceptor_subnet1" {
#   provider = aws.us-west
#   vpc_id     = aws_vpc.acceptor_vpc.id
#   cidr_block = var.acceptor_subnet1_cidr
#   availability_zone = var.acceptor_subnet1_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch 

#   tags = {
#     Name = var.acceptor_subnet1_name
#   }
# }


# resource "aws_subnet" "acceptor_subnet2" {
#   provider = aws.us-west
#   vpc_id     = aws_vpc.acceptor_vpc.id
#   cidr_block = var.acceptor_subnet2_cidr
#   availability_zone = var.acceptor_subnet2_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch 

#   tags = {
#     Name = var.acceptor_subnet2_name
#   }
# }

# ### Public Subnet ###
# resource "aws_subnet" "acceptor_public_subnet" {
#   provider = aws.us-west
#   vpc_id     = aws_vpc.acceptor_vpc.id
#   cidr_block = var.acceptor_pub_sub_cidr
#   availability_zone = var.acceptor_subnet1_az
#   map_public_ip_on_launch = var.map_public_ip_on_launch   #tfsec:ignore:aws-ec2-no-public-ip-subnet

#   tags = {
#     Name = "${var.acceptor_vpc_name}-public-subnet"
#   }
# }