
resource "aws_vpc" "destination_vpc" {  #tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
  cidr_block       = var.dest_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  provider = aws.us-west
  

  tags = {
    Name = var.dest_vpc_name
    Environment = var.environment
  }
}

### Elastic IP for NAT Gateway ###
resource "aws_eip" "nat_eip" {
  provider = aws.us-west

  tags = {
    Name = "${var.dest_vpc_name}-nat-eip"
  }

  depends_on = [ aws_vpc.destination_vpc ]
}
resource "aws_nat_gateway" "dest_nat_gw" {
  provider = aws.us-west
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.dest_public_subnet.id

  tags = {
    Name = "${var.dest_vpc_name}-nat-gateway"
  }

  depends_on = [ aws_eip.nat_eip ]
}

### Internet Gateway ###
resource "aws_internet_gateway" "dest_igw" {
  provider = aws.us-west
  vpc_id   = aws_vpc.destination_vpc.id

  depends_on = [ aws_vpc.destination_vpc ]

  tags = {
    Name = "${var.dest_vpc_name}-igw"
  }
}



