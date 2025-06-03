### -------------- Security Group for Source VPC ------------- ###
resource "aws_security_group" "source_sg" {
  provider = aws.us-east
  vpc_id   = aws_vpc.source_vpc.id
  description = "Security group for source VPC"
}

resource "aws_security_group_rule" "icmp_source" {
  provider          = aws.us-east
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.source_sg.id
  cidr_blocks       = [var.dest_cidr] 
  

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.source_sg ]
}



resource "aws_vpc_security_group_egress_rule" "source_egress" {
  security_group_id = aws_security_group.source_sg.id
  provider          = aws.us-east

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"

}


### ---------------- Destination VPC Security Group ------------- ###

### Security Group for destination VPC ###

resource "aws_security_group" "dest_sg" {
  provider = aws.us-west
  vpc_id   = aws_vpc.destination_vpc.id
  description = "Security group for destination VPC"
}

resource "aws_security_group_rule" "icmp_dest" {
  provider          = aws.us-west
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.dest_sg.id
  cidr_blocks       = [var.source_cidr] 

  description = "Allow ICMP from source VPC"
  
  depends_on = [ aws_security_group.dest_sg ]
}



resource "aws_vpc_security_group_egress_rule" "dest_egress" {
  security_group_id = aws_security_group.dest_sg.id
  provider = aws.us-west

  cidr_ipv4   = "0.0.0.0/0"  #tfsec:ignore:aws-vpc-no-public-egress-sgr
  ip_protocol = "-1"


}
