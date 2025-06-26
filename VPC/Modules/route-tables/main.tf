#########################################################################
# Route Tables for VPC
# #########################################################################

#########################################################################
# Public RT and Rules
##########################################################################



resource "aws_route_table" "public" {
  for_each      = var.public_route_tables
  vpc_id        = each.value.vpc_id
  region        = each.value.region
  tags          = merge(
    {
      Name = "${var.name}-public-route-table"
    },
    var.tags
  )
}

resource aws_route "public_routes" {
  for_each      = var.public_routes

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id                = lookup(each.value, "gateway_id", null)
  nat_gateway_id            = lookup(each.value, "nat_gateway_id", null)
  vpc_peering_connection_id = lookup(each.value, "vpc_peering_connection_id", null)
  transit_gateway_id        = lookup(each.value, "transit_gateway_id", null)
 
 depends_on              = [aws_route_table.public  ]

}


#########################################################################
# Public RT Association
#########################################################################

resource "aws_route_table_association" "public_association" {
  for_each = var.public_route_table_associations
  subnet_id = each.value.subnet_id
  route_table_id = each.value.route_table_id
}

#########################################################################
# Private RT and Rules
#########################################################################

resource "aws_route_table" "private" {
  for_each      = var.private_route_tables
  vpc_id        = each.value.vpc_id
  region        = each.value.region
  tags = merge(
    {
      Name = "${var.name}-private-route-table"
    },
    var.tags
  )
}
resource "aws_route" "private_routes" {
  for_each       = var.private_routes
  route_table_id = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id                = lookup(each.value, "gateway_id", null)
  nat_gateway_id            = lookup(each.value, "nat_gateway_id", null)
  vpc_peering_connection_id = lookup(each.value, "vpc_peering_connection_id", null)
  transit_gateway_id        = lookup(each.value, "transit_gateway_id", null)


  
  depends_on = [aws_route_table.private  ]
}

#########################################################################
# Private RT Association
#########################################################################

resource "aws_route_table_association" "private_association" {
  for_each = var.private_route_table_associations
  subnet_id = each.value.subnet_id
  route_table_id = each.value.route_table_id
}
















###########################################################################
# Old Code for Public and Private Route Tables
###########################################################################

# resource "aws_route_table_association" "private_association" {
#   for_each        = toset(var.private_route_table_associations)
#   subnet_id = each.value
#   route_table_id  = aws_route_table.private[each.key]

#   depends_on = [aws_route_table.private  ]
# }



# resource "aws_route_table_association" "public_association" {
#   for_each       = toset(var.public_route_table_associations)
#   subnet_id      = each.value
#   route_table_id = each.value.route_table_id

  
#   depends_on     = [aws_route_table.public  ]
# }







# locals{
#     create_public_route_table  = length(var.public_subnets_cidr_blocks) > 0
#     create_private_route_table = length(var.private_subnets_cidr_blocks) > 0
#     create_route_to_igw        = local.create_public_route_table
#     create_route_to_nat        = local.create_private_route_table



# }


#########################################################################
# Old Code for Public and Private Route Tables
#########################################################################

# resource "aws_route_table" "public" {
#     count  = local.create_public_route_table ? 1:0
#     vpc_id = var.vpc_id

#     tags = merge(
#       {
#         Name = "${var.name}-public-route-table"
#       },
#       var.tags
#     )
# }

# resource "aws_route" "public_internet_gateway" {
#   count = local.create_route_to_igw ? 1:0

#   route_table_id         = aws_route_table.public[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = var.igw_id


# }




















# resource "aws_route_table" "private" {
#   for_each = local.create_private_route_table ? toset(["private"]) : toset([])

#   vpc_id = var.vpc_id

#   tags = merge(
#     {
#       Name = "${var.name}-private-route-table"
#     },
#     var.tags
#   )
# }



# resource "aws_route_table" "private" {
#     count  = local.create_private_route_table ? 1:0
#     vpc_id = var.vpc_id

#     tags = merge(
#       {
#         Name = "${var.name}-private-route-table"
#       },
#       var.tags
#     )
# }


# resource "aws_route" "private_nat_gateway" {
#   count = local.create_private_route_table ? 1 : 0

#   route_table_id         = aws_route_table.private[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = var.nat_id

# }

#########################################################################
# Private RT Association
#########################################################################
# resource "aws_route_table_association" "private_association" {
#   count = var.create_private_subnets ? length(var.private_subnets) : 0

#   subnet_id      = var.private_subnets[count.index]
#   route_table_id = aws_route_table.private[0].id
  
# }