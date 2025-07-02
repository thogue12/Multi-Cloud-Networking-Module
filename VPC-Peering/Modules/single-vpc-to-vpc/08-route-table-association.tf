### Route Table Association for Source ###

resource "aws_route_table_association" "a" {
  provider = aws.us-east
  subnet_id      = aws_subnet.requester_subnet1.id
  route_table_id = aws_route_table.requestor_rt.id

  depends_on = [ aws_route_table.requestor_rt ]
}

resource "aws_route_table_association" "b" {
  provider = aws.us-east
  subnet_id      = aws_subnet.requester_subnet2.id
  route_table_id = aws_route_table.requestor_rt.id

  depends_on = [ aws_route_table.requestor_rt ]
}

resource "aws_route_table_association" "pub_a" {
  provider = aws.us-east
  subnet_id      = aws_subnet.requester_public_subnet.id
  route_table_id = aws_route_table.public_source_rt.id

  depends_on = [ aws_route_table.public_source_rt ]
}

### Route Table Association for Destination VPC Public Subnet

resource "aws_route_table_association" "c" {
  provider = aws.us-west
  subnet_id      = aws_subnet.acceptor_subnet1.id
  route_table_id = aws_route_table.this_rt.id

  depends_on = [ aws_route_table.this_rt ]
}

resource "aws_route_table_association" "d" {
  provider = aws.us-west
  subnet_id      = aws_subnet.acceptor_subnet2.id
  route_table_id = aws_route_table.this_rt.id
  
  depends_on = [ aws_route_table.this_rt ]
}

resource "aws_route_table_association" "dest_d" {
  provider = aws.us-west
  subnet_id      = aws_subnet.acceptor_public_subnet.id
  route_table_id = aws_route_table.this_pub_rt.id
  
  depends_on = [ aws_route_table.this_pub_rt ]
}
