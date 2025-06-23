variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

}

variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)

}
variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}

variable "name" {
  description = "Global name for all resources"
  type = string
  default = ""
}

variable "vpc_id" {
  description = "VPC ID"
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