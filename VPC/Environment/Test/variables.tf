
##########################################################
# VPC
##########################################################
variable "name" {
  description = "Global name for all resources"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = ""
}

variable "enable_dns_support" {
  description = "Enable DNS Support for VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable Hostnames for VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {}
}

##########################################################
#Subnets
##########################################################

variable "create_private_subnets" {
  description = "Bool to create private subnets"
  type        = bool
  default     = true
}

variable "create_pub_subs" {
  description = "Bool to create public subnets"
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

variable "map_public_ip_on_private_subs" {
  description = "Map public IP on launch for public subnets"
  type        = bool
  default     = false

}

variable "private_subnets_cidr_blocks" {
  description = "List of private subnets CIDR blocks"
  type        = list(string)
  default     = [""]
}

#### Route Tables ####
# variable "public_subnets" {
#   description = "List of IDs of public subnets"
# }

# variable "private_subnets" {
#   description = "List of IDs of private subnets"

# }
# variable "igw_id" {
#   description = "Internet Gateway ID"
#   type = string
# }

# variable "nat_id" {
#   description = "NAT Gateway ID"
#   type = string
# }
