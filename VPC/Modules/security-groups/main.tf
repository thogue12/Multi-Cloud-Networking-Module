######################################################################
###  Security Group ###
#######################################################################


resource "aws_security_group" "this" {
  for_each = var.security_groups
  vpc_id   = each.value.vpc_id
  description = each.value.description
}



resource "aws_security_group_rule" "this" {
  for_each = var.ingress_rules
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = each.value.security_group_id
  cidr_blocks       = each.value.cidr_blocks
  

}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = var.egress_rules
  security_group_id = each.value.security_group_id

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"

}













































# resource "aws_security_group" "this_sg" {
#   vpc_id   = var.vpc_id
#   # provider = each.value.region == "us-east-1" ? aws.us-east : aws.us-west
#   description = var.security_group_description
#   tags = merge(
#     {
#       Name = "${var.name}-sg"
#     },
#     var.tags
#   )
# }




# resource "aws_security_group_rule" "ingress" {

#   for_each = {
#     for i, rule in var.ingress_rules : "rule-${i}" => rule
#   }

#   type                     = "ingress"
#   from_port                = each.value.from_port
#   to_port                  = each.value.to_port
#   protocol                 = each.value.protocol
#   description              = each.value.description
#   cidr_blocks              = lookup(each.value, "cidr_blocks", [])
#   security_group_id        = aws_security_group.this_sg.id
# }
























# resource "aws_security_group_rule" "ingress" {
#   for_each          = var.ingress_rules 
#   type              = "ingress"
#   from_port         = each.value.from_port
#   to_port           = each.value.to_port
#   protocol          = each.value.protocol
#   security_group_id = aws_security_group.this_sg.id
#   cidr_blocks       = [each.value.cidr_blocks] 
  
#   description = each.value.description
  
#   depends_on = [ aws_security_group.this_sg ]
# }

