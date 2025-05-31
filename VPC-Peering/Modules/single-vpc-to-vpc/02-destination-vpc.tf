
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

resource "aws_subnet" "dest_subnet1" {
  provider = aws.us-west
  vpc_id     = aws_vpc.destination_vpc.id
  cidr_block = var.dest_subnet1_cidr
  availability_zone = var.dest_subnet1_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.dest_subnet1_name
  }
}


resource "aws_subnet" "dest_subnet2" {
  provider = aws.us-west
  vpc_id     = aws_vpc.destination_vpc.id
  cidr_block = var.dest_subnet2_cidr
  availability_zone = var.dest_subnet2_az
  map_public_ip_on_launch = false

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
  map_public_ip_on_launch = true  #tfsec:ignore:aws-ec2-no-public-ip-subnet

  tags = {
    Name = "${var.dest_vpc_name}-public-subnet"
  }
}

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

resource "aws_route_table_association" "c" {
  provider = aws.us-west
  subnet_id      = aws_subnet.dest_subnet1.id
  route_table_id = aws_route_table.this_rt.id

  depends_on = [ aws_route_table.this_rt ]
}

resource "aws_route_table_association" "d" {
  provider = aws.us-west
  subnet_id      = aws_subnet.dest_subnet2.id
  route_table_id = aws_route_table.this_rt.id
  
  depends_on = [ aws_route_table.this_rt ]
}

resource "aws_route_table_association" "dest_d" {
  provider = aws.us-west
  subnet_id      = aws_subnet.dest_public_subnet.id
  route_table_id = aws_route_table.this_pub_rt.id
  
  depends_on = [ aws_route_table.this_pub_rt ]
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

### Security Group for destination VPC ###

resource "aws_security_group" "dest_sg" {
  provider = aws.us-west
  vpc_id   = aws_vpc.destination_vpc.id
  description = "Security group for destination VPC"
}

resource "aws_security_group_rule" "ssh_dest" {
  provider = aws.us-west
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.dest_sg.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr

  description = "Allow ICMP from source VPC"
  
  depends_on = [ aws_security_group.dest_sg ]
}
resource "aws_security_group_rule" "icmp_dest" {
  provider = aws.us-west
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "icmp"
  security_group_id = aws_security_group.dest_sg.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr

  description = "Allow ICMP from source VPC"
  
  depends_on = [ aws_security_group.dest_sg ]
}


resource "aws_vpc_security_group_egress_rule" "dest_egress" {
  security_group_id = aws_security_group.dest_sg.id
  provider = aws.us-west

  cidr_ipv4   = "0.0.0.0/0" #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ip_protocol = "-1"


}

### EC2 Instance in Source VPC ###
resource "aws_instance" "dest_instance" {
  provider = aws.us-west
  ami           = "ami-075686beab831bb7f" # use the ami from your specific region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dest_subnet1.id
  vpc_security_group_ids = [aws_security_group.dest_sg.id]
  metadata_options {
     http_tokens = "required"
     }  

  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "${var.dest_vpc_name}-instance"
  }

  depends_on = [aws_vpc.destination_vpc, aws_subnet.dest_subnet1]
}