#########################################################################
# Route Tables for VPC
#########################################################################
locals{
    create_public_route_table  = var.create_vpc && length(var.public_subnets_cidr_blocks) > 0
    create_private_route_table = var.create_vpc && length(var.private_subnets_cidr_blocks) > 0
    create_route_to_igw        = var.create_vpc && var.create_igw && local.create_public_route_table
    create_route_to_nat        = var.create_vpc && var.create_nat && local.create_private_route_table

}
#########################################################################
# Public RT and Rules
#########################################################################
resource "aws_route_table" "public" {
    count  = local.create_public_route_table ? 1:0
    vpc_id = aws_vpc.this_vpc[0].id

    tags = merge(
      {
        Name = "${var.name}-public-route-table"
      },
      var.tags
    )
}
resource "aws_route" "public_internet_gateway" {
  count = local.create_route_to_igw ? 1:0

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this_igw[0].id


}

#########################################################################
# Public RT Association
#########################################################################
resource "aws_route_table_association" "public_association" {
  count = local.create_public_subnets ? length(aws_subnet.public_subnets) : 0

  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
  
}


#########################################################################
# Private RT and Rules
#########################################################################

resource "aws_route_table" "private" {
    count  = local.create_private_route_table ? 1:0
    vpc_id = aws_vpc.this_vpc[0].id

    tags = merge(
      {
        Name = "${var.name}-private-route-table"
      },
      var.tags
    )
}


resource "aws_route" "private_nat_gateway" {
  count = var.create_vpc && local.create_public_route_table ? 1 : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.this_nat[0].id

}

#########################################################################
# Private RT Association
#########################################################################
resource "aws_route_table_association" "private_association" {
  count = local.create_private_subnets ? length(aws_subnet.private_subnets) : 0

  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private[0].id
  
}