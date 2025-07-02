### -------- vpc a route table --------- ###
resource "aws_route_table" "vpc_a_route_table" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc_a_nat_gateway.id
    
  }

    route {
      cidr_block = var.vpc_b_cidr
      vpc_peering_connection_id  = aws_vpc_peering_connection.connection_a.id
    
  }

    route {
      cidr_block = var.vpc_c_cidr
      vpc_peering_connection_id  = aws_vpc_peering_connection.connection_b.id
    
  }

  tags = {
    Name = "${var.vpc_a_name}-route-table"
  }

  depends_on = [ aws_vpc.vpc_a ]
}

### -------- vpc b route table --------- ###
resource "aws_route_table" "vpc_b_route_table" {
  vpc_id = aws_vpc.vpc_b.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.vpc_b_nat_gateway.id
    
  }
    route {
      cidr_block = var.vpc_c_cidr
      vpc_peering_connection_id  = aws_vpc_peering_connection.connection_c.id
    
  }

    route {
      cidr_block = var.vpc_a_cidr
      vpc_peering_connection_id  = aws_vpc_peering_connection.connection_a.id
    
  }


  tags = {
    Name = "${var.vpc_b_name}-route-table"
  }
  depends_on = [ aws_vpc.vpc_b, aws_vpc.vpc_c  ]
}

### -------- vpc c route table --------- ###
resource "aws_route_table" "vpc_c_route_table" {
  vpc_id = aws_vpc.vpc_c.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc_c_nat_gateway.id
    
  }

   route {
     cidr_block = var.vpc_a_cidr
     vpc_peering_connection_id  = aws_vpc_peering_connection.connection_b.id
    
  }

   route {
     cidr_block = var.vpc_b_cidr
     vpc_peering_connection_id  = aws_vpc_peering_connection.connection_c.id
    
  }
  tags = {
    Name = "${var.vpc_c_name}-route-table"
  }
  depends_on = [ aws_vpc.vpc_c, aws_vpc.vpc_a ]
}