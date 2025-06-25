##########################################################################
# Private Subnets
###########################################################################




resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block[0]
  availability_zone = each.value.availability_zone[0]
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    {
      Name = "${var.name}-${each.key}"
    },
    var.tags
  )
  
}








### Create private subnets if the list of CIDR blocks is not empty
# locals {
#   create_private_subnets = length(var.private_subnets_cidr_blocks) > 0
  
# }

# resource "aws_subnet" "private_subnets" {
#   count = var.create_private_subnets ? length(var.private_subnets_cidr_blocks) : 0
#   map_public_ip_on_launch = var.map_public_ip_on_private_subs
#   vpc_id =var.vpc_id
#   cidr_block = var.private_subnets_cidr_blocks[count.index]
#   availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

#   tags = merge(
#     {
#       Name = "${var.name}private-subnet-${count.index + 1}"
#     },
#     var.tags
#   )
# }