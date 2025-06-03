### Source/Requester VPC Route Tables ###

resource "aws_route_table" "this_source_rt" {
  vpc_id = aws_vpc.source_vpc.id
  provider = aws.us-east

  route {
    cidr_block = var.dest_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this_connection.id
  }
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.source_nat_gw.id

  }
  tags = {
    Name = var.source_rt_name
  }
  depends_on = [ aws_vpc.source_vpc ]
}

### Public route table for source VPC ###
resource "aws_route_table" "public_source_rt" {
  vpc_id = aws_vpc.source_vpc.id
  provider = aws.us-east

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_igw.id
  }

    route {
    cidr_block = var.dest_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this_connection.id
  }
  tags = {
    Name = "${var.source_vpc_name}-public-route-table"
  }
  depends_on = [ aws_vpc.source_vpc ]
}

### Destination/ Accepter VPC Route Tables ###

### Private route table for destination VPC ###
resource "aws_route_table" "this_rt" {
  vpc_id = aws_vpc.destination_vpc.id
  provider = aws.us-west

  route {
    cidr_block = var.source_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this_connection.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dest_nat_gw.id
  }

  tags = {
    Name = var.dest_rt_name
  }
  depends_on = [ aws_vpc.destination_vpc ]
}

### Route Table for Public Subnet ###
resource "aws_route_table" "this_pub_rt" {
  vpc_id = aws_vpc.destination_vpc.id
  provider = aws.us-west

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.dest_igw.id
    
  }

  tags = {
    Name = "${var.dest_vpc_name}-public-route-table"
  }
  depends_on = [ aws_vpc.destination_vpc ]
}


