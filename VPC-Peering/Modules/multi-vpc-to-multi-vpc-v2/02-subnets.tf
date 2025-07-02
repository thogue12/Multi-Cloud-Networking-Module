### -------- vpc a subnets -------- ###

resource "aws_subnet" "vpc_a_subnet_1" {
    vpc_id = aws_vpc.vpc_a.id
    cidr_block = var.vpc_a_subnet_1_cidr
    availability_zone = var.vpc_a_subnet_1_availability_zone
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.vpc_a_name}-subnet-1"
    }
  
}
### -------- vpc b subnets -------- ###

resource "aws_subnet" "vpc_b_subnet_1" {
    vpc_id = aws_vpc.vpc_b.id
    cidr_block = var.vpc_b_subnet_1_cidr
    availability_zone = var.vpc_b_subnet_1_availability_zone
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.vpc_b_name}-subnet-1"
    }
  
}
### -------- vpc c subnets -------- ###

resource "aws_subnet" "vpc_c_subnet_1" {
    vpc_id = aws_vpc.vpc_c.id
    cidr_block = var.vpc_c_subnet_1_cidr
    availability_zone = var.vpc_c_subnet_1_availability_zone
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.vpc_c_name}-subnet-1"
    }
  
}