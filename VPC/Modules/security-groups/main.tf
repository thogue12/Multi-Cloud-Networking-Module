######################################################################
###  Security Group ###
######################################################################
resource "aws_security_group" "this_sg" {
  vpc_id   = var.vpc_id
  description = var.security_group_description
  

  tags = merge(
    {
      Name = "${var.name}-sg"
    },
    var.tags
  )
}




resource "aws_security_group_rule" "ingress" {
  for_each = {
    for i, rule in var.ingress_rules : "rule-${i}" => rule
  }

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  description              = each.value.description
  cidr_blocks              = lookup(each.value, "cidr_blocks", [])
  security_group_id        = aws_security_group.this_sg.id
}
























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

