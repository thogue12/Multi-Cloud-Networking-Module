#########################################################################
# Route Tables for VPC
#########################################################################
locals{
    create_public_route_table  = length(var.public_subnets_cidr_blocks) > 0
    create_private_route_table = length(var.private_subnets_cidr_blocks) > 0
    create_route_to_igw        = local.create_public_route_table
    create_route_to_nat        = local.create_private_route_table



}
#########################################################################
# Public RT and Rules
#########################################################################
resource "aws_route_table" "public" {
    count  = local.create_public_route_table ? 1:0
    vpc_id = var.vpc_id

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
  gateway_id             = var.igw_id


}

#########################################################################
# Public RT Association
#########################################################################
resource "aws_route_table_association" "public_association" {
  count = var.create_public_subnets ? length(var.public_subnets) : 0

  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public[0].id
  
}


#########################################################################
# Private RT and Rules
#########################################################################

resource "aws_route_table" "private" {
    count  = local.create_private_route_table ? 1:0
    vpc_id = var.vpc_id

    tags = merge(
      {
        Name = "${var.name}-private-route-table"
      },
      var.tags
    )
}


resource "aws_route" "private_nat_gateway" {
  count = local.create_private_route_table ? 1 : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_id

}

#########################################################################
# Private RT Association
#########################################################################
resource "aws_route_table_association" "private_association" {
  count = var.create_private_subnets ? length(var.private_subnets) : 0

  subnet_id      = var.private_subnets[count.index]
  route_table_id = aws_route_table.private[0].id
  
}