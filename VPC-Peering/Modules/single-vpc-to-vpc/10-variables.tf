# variable "environment" {
#   description = "The environment for the VPC (e.g., dev, staging, prod)"
#   type        = string
  
# }

# variable "requestor_vpc_region" {
#   description = "The AWS region for the source VPC"
#   type        = string
# }

# variable "acceptor_region" {
#   description = "The AWS region for the destination VPC"
#   type        = string
  
# }


# ### Source VPC Variables ###


# variable "requester_vpc_name" {
#   description = "Name for the source VPC"
#   type        = string
  
# }

# variable "requester_vpc_cidr" {
#   description = "CIDR block for the destination VPC"
#   type        = string
# }

# variable "requester_vpc_pub_sub_cidr" {
#   description = "CIDR block for the public subnet"
#   type        = string 
# }

# variable "requester_subnet1_cidr" {
#   description = "CIDR block for the first destination subnet"
#   type        = string
  
# } 

# variable "requester_subnet1_name" {
#   description = "Name for the first destination subnet"
#   type        = string
  
# }

# variable "requester_subnet1_az" {
#   description = "Availability Zone for the first destination subnet"
#   type        = string  
  
# }

# variable "requester_subnet2_name" {
#   description = "Name for the second destination subnet"
#   type        = string
  
# }

# variable "requester_subnet2_cidr" {
#   description = "CIDR block for the second destination subnet"
#   type        = string
  
# }


# variable "requester_subnet2_az" {
#   description = "Availability Zone for the second destination subnet"
#   type        = string
  
# }

# variable "requester_rt_name" {
#   description = "Name for the destination route table"
#   type        = string  
  
# }

# ### Acceptor VPC Variables ###

# variable "acceptor_vpc_name" {
#   description = "Name for the source VPC"
#   type        = string
  
# }
# variable "acceptor_cidr" {
#   description = "CIDR block for the destination VPC"
#   type        = string
# }


# variable "acceptor_subnet1_cidr" {
#   description = "CIDR block for the first destination subnet"
#   type        = string
  
# } 

# variable "acceptor_subnet1_name" {
#   description = "Name for the first destination subnet"
#   type        = string
  
# }

# variable "acceptor_subnet1_az" {
#   description = "Availability Zone for the first destination subnet"
#   type        = string  
  
# }

# variable "acceptor_subnet2_name" {
#   description = "Name for the second destination subnet"
#   type        = string
  
# }

# variable "acceptor_pub_sub_cidr" {
#   description = "CIDR block for the public subnet"
#   type        = string 
# }

# variable "acceptor_subnet2_cidr" {
#   description = "CIDR block for the second destination subnet"
#   type        = string
  
# }


# variable "acceptor_subnet2_az" {
#   description = "Availability Zone for the second destination subnet"
#   type        = string
  
# }

# variable "acceptor_rt_name" {
#   description = "Name for the destination route table"
#   type        = string  
  
# }
# variable "map_public_ip_on_launch" {
#   description = "Whether to map public IPs on launch for subnets, defaults to false"
#   type        = bool
#   default     = false
  
# }

# ### EC2 Instance Variables ###

# variable "requester_ami_id" {
#   description = "ami id for the source VPC EC2 instance. MUST BE REGION SPECIFIC"
#   type        = string
# }

# variable "acceptor_ami_id" {
#   description = "ami id for the destination VPC EC2 instance. MUST BE REGION SPECIFIC"
#   type        = string
# }
# variable "instance_type" {
#   description = "Instance type for the EC2 instances in both VPCs"
#   type        = string
#   default     = "t2.micro"
# }