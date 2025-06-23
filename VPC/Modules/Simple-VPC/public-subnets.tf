##########################################################################
# Public Subnets
##########################################################################

## Create public subnets if the list of CIDR blocks is not empty
locals {
  create_public_subnets = length(var.public_subnets_cidr_blocks) > 0
}

resource "aws_subnet" "public_subnets" {
    count = var.create_vpc ? length(var.public_subnets_cidr_blocks) : 0
    vpc_id = aws_vpc.this_vpc[0].id
    cidr_block = var.public_subnets_cidr_blocks[count.index]
    availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
    
    map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = "${var.name}-public-subnet-${count.index + 1}"
    },
    var.tags
  )
  
}