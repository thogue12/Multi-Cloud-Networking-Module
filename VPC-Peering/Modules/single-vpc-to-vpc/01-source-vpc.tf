
resource "aws_vpc" "source_vpc" {  #tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
  cidr_block       = var.source_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  provider = aws.us-east
  

  tags = {
    Name = var.source_vpc_name
  }
}


### Elastic IP for NAT Gateway ###
resource "aws_eip" "source_nat_eip" {
  provider = aws.us-east

  tags = {
    Name = "${var.source_vpc_name}-nat-eip"
  }

  depends_on = [ aws_vpc.source_vpc ]
}

resource "aws_nat_gateway" "source_nat_gw" {
  provider = aws.us-east
  allocation_id = aws_eip.source_nat_eip.id
  subnet_id     = aws_subnet.source_public_subnet.id

  tags = {
    Name = "${var.source_vpc_name}-nat-gateway"
  }

  depends_on = [aws_eip.source_nat_eip  ]
}
### Internet Gateway ###  
resource "aws_internet_gateway" "this_igw" {
  provider = aws.us-east
  vpc_id   = aws_vpc.source_vpc.id


  depends_on = [ aws_vpc.source_vpc ]

  tags = {
    Name = "${var.source_vpc_name}-igw"
  }
}



