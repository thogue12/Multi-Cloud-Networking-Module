### ------ Source VPC Variables ------ ###
source_region       = "us-east-1"
environment         = "test"
source_cidr         = "10.0.0.0/16"
source_vpc_name     = "source-vpc"
source_subnet1_cidr = "10.0.0.0/24"
source_subnet1_name = "source-subnet-1"
source_subnet1_az   = "us-east-1a"
source_subnet2_name = "source-subnet-2"
source_subnet2_cidr = "10.0.1.0/24"
source_subnet2_az   = "us-east-1b"
source_rt_name      = "source-route-table"
source_pub_sub_cidr = "10.0.2.0/24"


### ------ Destination VPC Variables ------ ###
dest_region       = "us-west-2"
dest_cidr         = "10.10.0.0/16"
dest_vpc_name     = "destination-vpc"
dest_subnet1_cidr = "10.10.0.0/24"
dest_subnet1_name = "destination-subnet-1"
dest_subnet1_az   = "us-west-2a"
dest_subnet2_name = "destination-subnet-2"
dest_subnet2_cidr = "10.10.1.0/24"
dest_subnet2_az   = "us-west-2b"
dest_rt_name      = "destination-route-table"
dest_pub_sub_cidr = "10.10.2.0/24"
map_public_ip_on_launch = false