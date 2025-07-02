### --------- vpc A route table association --------- ###
resource "aws_route_table_association" "vpc_a_subnet_1_association" {
  subnet_id      = aws_subnet.vpc_a_subnet_1.id
  route_table_id = aws_route_table.vpc_a_route_table.id

  depends_on = [ aws_route_table.vpc_a_route_table ]
  
}

### --------- vpc B route table association --------- ###
resource "aws_route_table_association" "vpc_b_subnet_1_association" {
  subnet_id      = aws_subnet.vpc_b_subnet_1.id
  route_table_id = aws_route_table.vpc_b_route_table.id
  
  depends_on = [ aws_route_table.vpc_b_route_table ]
}

### --------- vpc C route table association --------- ###
resource "aws_route_table_association" "vpc_c_subnet_1_association" {
  subnet_id      = aws_subnet.vpc_c_subnet_1.id
  route_table_id = aws_route_table.vpc_c_route_table.id
  
  depends_on = [ aws_route_table.vpc_c_route_table ]
}