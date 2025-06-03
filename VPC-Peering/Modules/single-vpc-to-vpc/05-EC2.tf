### EC2 Instance in Source VPC ###
resource "aws_instance" "source_instance" {
  provider = aws.us-east
  ami           = var.requester_ami_id # use the ami from your specific region
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  subnet_id     = aws_subnet.requester_subnet1.id
  vpc_security_group_ids = [aws_security_group.requester_sg.id]
  metadata_options {
     http_tokens = "required"
     }  
    root_block_device {
      encrypted = true
  }
  tags = {
    Name = "${var.requester_vpc_name}-instance"
  }

  depends_on = [aws_vpc.requester_vpc, aws_subnet.requester_subnet1]
}

### EC2 Instance in Destination VPC ###
resource "aws_instance" "acceptor_instance" {
  provider = aws.us-west
  ami           = var.acceptor_ami_id # use the ami from your specific region
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  subnet_id     = aws_subnet.acceptor_subnet1.id
  vpc_security_group_ids = [aws_security_group.acceptor_sg.id]
  metadata_options {
     http_tokens = "required"
     }  

  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "${var.acceptor_vpc_name}-instance"
  }

  depends_on = [aws_vpc.acceptor_vpc, aws_subnet.acceptor_subnet1]
}
