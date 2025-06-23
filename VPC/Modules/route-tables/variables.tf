variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}
variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = [""]

}
variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for private_ subnets"
  type        = list(string)
  default     = [""]

}

variable "name" {
  description = "Global name for all resources"
  type = string
  default = ""
}
variable "create_public_subnets" {
  description = "value of create_public_subnets local variable"
  type = string

}

variable "create_private_subnets" {
  description = "value of create_private_subnets local variable"
  type = string
  
}

variable "public_subnets" {
  description = "List of IDs of public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "List of IDs of private subnets"
    type = list(string)
  
}
variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "igw_id" {
  description = "Internet Gateway ID"
  type = string
}

variable "nat_id" {
  description = "NAT Gateway ID"
  type = string
}