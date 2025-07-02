########################################################################
# EC2 Instance
########################################################################

resource "aws_instance" "this" {
  for_each = var.instance_attributes 
  ami = "ami-000ec6c25978d5999"
  instance_type = each.value.instance_type
  iam_instance_profile = each.value.iam_instance_profile
  subnet_id     = each.value.subnet_id ## Ensure this is the private subnet, for SSM access
  vpc_security_group_ids = each.value.vpc_security_group_ids
  metadata_options {
     http_tokens = "required"
     }  
    root_block_device {
      encrypted = true
  }
  tags = {
    Name = "${var.name}-instance"
  }

}