
##############################################################
# Module: igw-nat
################################################################
## Create IGW and NAT Gateway if the VPC is created and the respective subnet CIDR blocks are provided


locals {
  create_igw =  length(var.public_subnets_cidr_blocks) > 0
  create_nat_gateway = length(var.private_subnets_cidr_blocks) > 0
  create_eip =  length(var.private_subnets_cidr_blocks) > 0
}

resource "aws_eip" "this_eip" {
  count = local.create_eip ? 1 : 0     

  tags = merge(
    {
      Name = "${var.name}-nat-eip"
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this_igw" {
  count = local.create_igw ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags
  )
  
}

resource "aws_nat_gateway" "this_nat" {
  count = local.create_nat_gateway ? 1:0
  allocation_id = aws_eip.this_eip[0].id
  subnet_id = var.public_subnets[0] # Assuming the first public subnet is used for the NAT Gateway

  tags = merge(
    {
      Name = "${var.name}-nat-gateway"
    },
    var.tags
  )
}