### --------- vpc a eip ----------- ###

resource "aws_eip" "vpc_a_eip" {
  tags = {
    Name = "${var.vpc_a_name}-eip"
  }
}

### vpc a nat gateway ###
resource "aws_nat_gateway" "vpc_a_nat_gateway" {
  allocation_id = aws_eip.vpc_a_eip.id
  subnet_id     = aws_subnet.vpc_a_subnet_1.id

  tags = {
    Name = "${var.vpc_a_name}-nat-gateway"
  }
}

### vpc a internet gateway ###
resource "aws_internet_gateway" "vpc_a_internet_gateway" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    Name = "${var.vpc_a_name}-internet-gateway"
  }
}

### ---------- vpc b eip ----------- ###

resource "aws_eip" "vpc_b_eip" {
  tags = {
    Name = "${var.vpc_b_name}-eip"
  }
}

### vpc a nat gateway ###
resource "aws_nat_gateway" "vpc_b_nat_gateway" {
  allocation_id = aws_eip.vpc_b_eip.id
  subnet_id     = aws_subnet.vpc_b_subnet_1.id

  tags = {
    Name = "${var.vpc_b_name}-nat-gateway"
  }
}

### vpc a internet gateway ###
resource "aws_internet_gateway" "vpc_b_internet_gateway" {
  vpc_id = aws_vpc.vpc_b.id

  tags = {
    Name = "${var.vpc_b_name}-internet-gateway"
  }
}

### --------- vpc c eip ----------- ###

resource "aws_eip" "vpc_c_eip" {
  tags = {
    Name = "${var.vpc_c_name}-eip"
  }
}

### vpc a nat gateway ###
resource "aws_nat_gateway" "vpc_c_nat_gateway" {
  allocation_id = aws_eip.vpc_c_eip.id
  subnet_id     = aws_subnet.vpc_c_subnet_1.id

  tags = {
    Name = "${var.vpc_c_name}-nat-gateway"
  }
}

### vpc a internet gateway ###
resource "aws_internet_gateway" "vpc_c_internet_gateway" {
  vpc_id = aws_vpc.vpc_c.id

  tags = {
    Name = "${var.vpc_c_name}-internet-gateway"
  }
}