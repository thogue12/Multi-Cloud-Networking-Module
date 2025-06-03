### Subnets for Source VPC ###
### Public Subnet ###
resource "aws_subnet" "source_public_subnet" {
  provider = aws.us-east
  vpc_id     = aws_vpc.source_vpc.id
  cidr_block = var.source_pub_sub_cidr
  availability_zone = var.source_subnet1_az
  map_public_ip_on_launch = var.map_public_ip_on_launch  #tfsec:ignore:aws-ec2-no-public-ip-subnet

  tags = {
    Name = "${var.source_vpc_name}-public-subnet"
  }
}

## Private Subnets ##
resource "aws_subnet" "source_subnet1" {
  provider = aws.us-east
  vpc_id     = aws_vpc.source_vpc.id
  cidr_block = var.source_subnet1_cidr
  availability_zone = var.source_subnet1_az
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name = var.source_subnet1_name
  }
}


resource "aws_subnet" "source_subnet2" {
  provider = aws.us-east
  vpc_id     = aws_vpc.source_vpc.id
  cidr_block = var.source_subnet2_cidr
  availability_zone = var.source_subnet2_az
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name = var.source_subnet2_name
  }
}

### Subnets for Destination VPC ###
resource "aws_subnet" "dest_subnet1" {
  provider = aws.us-west
  vpc_id     = aws_vpc.destination_vpc.id
  cidr_block = var.dest_subnet1_cidr
  availability_zone = var.dest_subnet1_az
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name = var.dest_subnet1_name
  }
}


resource "aws_subnet" "dest_subnet2" {
  provider = aws.us-west
  vpc_id     = aws_vpc.destination_vpc.id
  cidr_block = var.dest_subnet2_cidr
  availability_zone = var.dest_subnet2_az
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name = var.dest_subnet2_name
  }
}

### Public Subnet ###
resource "aws_subnet" "dest_public_subnet" {
  provider = aws.us-west
  vpc_id     = aws_vpc.destination_vpc.id
  cidr_block = var.dest_pub_sub_cidr
  availability_zone = var.dest_subnet1_az
  map_public_ip_on_launch = var.map_public_ip_on_launch   #tfsec:ignore:aws-ec2-no-public-ip-subnet

  tags = {
    Name = "${var.dest_vpc_name}-public-subnet"
  }
}