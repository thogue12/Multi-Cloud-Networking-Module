### -------------- Security Group VPC A ------------- ###
resource "aws_security_group" "vpc_a_sg" {
  vpc_id   = aws_vpc.vpc_a.id
  description = "Security group for VPC A"
}

resource "aws_security_group_rule" "icmp_source" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.vpc_a_sg.id
  cidr_blocks       = [var.acceptor_cidr] 
  

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.vpc_a_sg ]
}



resource "aws_vpc_security_group_egress_rule" "source_egress" {
  security_group_id = aws_security_group.vpc_a_sg.id

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"

}
### -------------- Security Group VPC B ------------- ###
resource "aws_security_group" "vpc_b_sg" {
  vpc_id   = aws_vpc.vpc_b.id
  description = "Security group for VPC B"
}

resource "aws_security_group_rule" "icmp_source" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.vpc_b_sg.id
  cidr_blocks       = [var.acceptor_cidr] 
  

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.vpc_b_sg ]
}



resource "aws_vpc_security_group_egress_rule" "source_egress" {
  security_group_id = aws_security_group.vpc_b_sg.id

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"

}
### -------------- Security Group VPC C ------------- ###
resource "aws_security_group" "vpc_c_sg" {
  vpc_id   = aws_vpc.vpc_c.id
  description = "Security group for source VPC"
}

resource "aws_security_group_rule" "icmp_source" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.vpc_c_sg.id
  cidr_blocks       = [var.acceptor_cidr] 
  

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.vpc_c_sg ]
}



resource "aws_vpc_security_group_egress_rule" "source_egress" {
  security_group_id = aws_security_group.vpc_c_sg.id

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"

}