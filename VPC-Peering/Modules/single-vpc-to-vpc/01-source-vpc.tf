
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

### Public Subnet ###
resource "aws_subnet" "source_public_subnet" {
  provider = aws.us-east
  vpc_id     = aws_vpc.source_vpc.id
  cidr_block = var.source_pub_sub_cidr
  availability_zone = var.source_subnet1_az
  map_public_ip_on_launch = true  #tfsec:ignore:aws-ec2-no-public-ip-subnet

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
  map_public_ip_on_launch = false

  tags = {
    Name = var.source_subnet1_name
  }
}


resource "aws_subnet" "source_subnet2" {
  provider = aws.us-east
  vpc_id     = aws_vpc.source_vpc.id
  cidr_block = var.source_subnet2_cidr
  availability_zone = var.source_subnet2_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.source_subnet2_name
  }
}

### Private route table for source VPC ###
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

### Public route table association for source VPC ###
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

resource "aws_route_table_association" "a" {
  provider = aws.us-east
  subnet_id      = aws_subnet.source_subnet1.id
  route_table_id = aws_route_table.this_source_rt.id

  depends_on = [ aws_route_table.this_source_rt ]
}

resource "aws_route_table_association" "b" {
  provider = aws.us-east
  subnet_id      = aws_subnet.source_subnet2.id
  route_table_id = aws_route_table.this_source_rt.id

  depends_on = [ aws_route_table.this_source_rt ]
}

resource "aws_route_table_association" "pub_a" {
  provider = aws.us-east
  subnet_id      = aws_subnet.source_public_subnet.id
  route_table_id = aws_route_table.public_source_rt.id

  depends_on = [ aws_route_table.public_source_rt ]
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

### Security Group for Source VPC ###
resource "aws_security_group" "source_sg" {
  provider = aws.us-east
  vpc_id   = aws_vpc.source_vpc.id
  description = "Security group for source VPC"
}

resource "aws_security_group_rule" "icmp_source" {
  provider = aws.us-east
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.source_sg.id
  cidr_blocks       = [var.dest_cidr] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.source_sg ]
}
resource "aws_security_group_rule" "ssh_source" {
  provider = aws.us-east
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.source_sg.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr

  description = "Allow ICMP from destination VPC"
  
  depends_on = [ aws_security_group.source_sg ]
}


resource "aws_vpc_security_group_egress_rule" "source_egress" {
  security_group_id = aws_security_group.source_sg.id
  provider = aws.us-east

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ip_protocol = "-1"

}


# }

### EC2 Instance in Source VPC ###
resource "aws_instance" "source_instance" {
  provider = aws.us-east
  ami           = "ami-084568db4383264d4" # use the ami from your specific region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.source_public_subnet.id
  vpc_security_group_ids = [aws_security_group.source_sg.id]
  metadata_options {
     http_tokens = "required"
     }  
    root_block_device {
      encrypted = true
  }
  tags = {
    Name = "${var.source_vpc_name}-instance"
  }

  depends_on = [aws_vpc.source_vpc, aws_subnet.source_subnet1]
}