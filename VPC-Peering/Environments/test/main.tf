

# module "single-vpc-to-vpc" {
#   source = "../../Modules/single-vpc-to-vpc"

#   providers = {
#     aws.us-east = aws.us-east
#     aws.us-west = aws.us-west
#   }

#   ### Source VPC Variables ###
#   environment                = var.environment
#   requestor_vpc_region       = var.requestor_vpc_region
#   requester_vpc_name         = "${var.requester_vpc_name}-${var.environment}"
#   requester_vpc_cidr         = var.requester_vpc_cidr
#   requester_vpc_pub_sub_cidr = var.requester_vpc_pub_sub_cidr
#   requester_subnet1_cidr     = var.requester_subnet1_cidr
#   requester_subnet1_name     = "${var.requester_subnet1_name}-${var.environment}"
#   requester_subnet1_az       = var.requester_subnet1_az
#   requester_subnet2_name     = "${var.requester_subnet2_name}-${var.environment}"
#   requester_subnet2_cidr     = var.requester_subnet2_cidr
#   requester_subnet2_az       = var.requester_subnet2_az
#   requester_rt_name          = "${var.requester_rt_name}-${var.environment}"
#   requester_ami_id           = var.requester_ami_id
#   instance_type              = var.instance_type


#   ### Destination VPC Variables ###
#   acceptor_region         = var.acceptor_region
#   acceptor_vpc_name       = "${var.acceptor_vpc_name}-${var.environment}"
#   acceptor_cidr           = var.acceptor_cidr
#   acceptor_subnet1_cidr   = var.acceptor_subnet1_cidr
#   acceptor_subnet1_name   = "${var.acceptor_subnet1_name}-${var.environment}"
#   acceptor_subnet1_az     = var.acceptor_subnet1_az
#   acceptor_subnet2_name   = "${var.acceptor_subnet2_name}-${var.environment}"
#   acceptor_subnet2_cidr   = var.acceptor_subnet2_cidr
#   acceptor_subnet2_az     = var.acceptor_subnet2_az
#   acceptor_rt_name        = "${var.acceptor_rt_name}-${var.environment}"
#   acceptor_pub_sub_cidr   = var.acceptor_pub_sub_cidr
#   acceptor_ami_id         = var.acceptor_ami_id
#   map_public_ip_on_launch = var.map_public_ip_on_launch

# }