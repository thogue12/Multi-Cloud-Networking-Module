

module "single-vpc-to-vpc" {
  source = "../../Modules/single-vpc-to-vpc"

  providers = {
    aws.us-east = aws.us-east
    aws.us-west = aws.us-west
  }

  ### Source VPC Variables ###
  environment         = var.environment
  source_region       = var.source_region
  source_vpc_name     = "${var.source_vpc_name}-${var.environment}"
  source_cidr         = var.source_cidr
  source_subnet1_cidr = var.source_subnet1_cidr
  source_subnet1_name = "${var.source_subnet1_name}-${var.environment}"
  source_subnet1_az   = var.source_subnet1_az
  source_subnet2_name = "${var.source_subnet2_name}-${var.environment}"
  source_subnet2_cidr = var.source_subnet2_cidr
  source_subnet2_az   = var.source_subnet2_az
  source_rt_name      = "${var.source_rt_name}-${var.environment}"
  source_pub_sub_cidr = var.source_pub_sub_cidr

  ### Destination VPC Variables ###
  dest_region       = var.dest_region
  dest_vpc_name     = "${var.dest_vpc_name}-${var.environment}"
  dest_cidr         = var.dest_cidr
  dest_pub_sub_cidr = var.dest_pub_sub_cidr
  dest_subnet1_cidr = var.dest_subnet1_cidr
  dest_subnet1_name = "${var.dest_subnet1_name}-${var.environment}"
  dest_subnet1_az   = var.dest_subnet1_az
  dest_subnet2_name = "${var.dest_subnet2_name}-${var.environment}"
  dest_subnet2_cidr = var.dest_subnet2_cidr
  dest_subnet2_az   = var.dest_subnet2_az
  dest_rt_name      = "${var.dest_rt_name}-${var.environment}"

}