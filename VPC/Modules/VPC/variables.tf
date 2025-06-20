variable "create_vpc" {
  description = "Create a new VPC"
  type        = bool
  default     = true

}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = [""]

}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
  default     = [""]

}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch for public subnets"
  type        = bool
  default     = true

}

######### private subnets #########
variable "private_subnets_cidr_blocks" {
  description = "List of private subnets CIDR blocks"
  type        = list(string)
  default     = [""]
}

######### NAT/ IGW #############
variable "create_nat" {
  description = "Create a NAT Gateway"
  type        = bool
  default     = true
}
variable "create_igw" {
  description = "Create an Internet Gateway"
  type        = bool
  default     = true
}
variable "tags"{
   description = "tags for each resource"
   type = map(string)
   default = {}
 }
 variable "name" {
    description = "universal name"
    type = string
    default = ""
 }
 