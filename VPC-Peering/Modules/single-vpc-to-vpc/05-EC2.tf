### EC2 Instance in Source VPC ###
resource "aws_instance" "source_instance" {
  provider = aws.us-east
  ami           = "ami-0554aa6767e249943" # use the ami from your specific region
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  subnet_id     = aws_subnet.source_subnet1.id
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

### EC2 Instance in Destination VPC ###
resource "aws_instance" "dest_instance" {
  provider = aws.us-west
  ami           = "ami-04999cd8f2624f834" # use the ami from your specific region
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
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
