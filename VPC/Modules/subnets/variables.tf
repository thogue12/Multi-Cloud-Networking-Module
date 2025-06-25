
variable "name" {
  description = "Global name for all resources"
  type = string
  default = ""
}


variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr_block           = list(string)
    availability_zone    = list(string)
    map_public_ip_on_launch = bool
    vpc_id               = string
  }))  
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr_block           = list(string)
    availability_zone    = list(string)
    map_public_ip_on_launch = bool
    vpc_id               = string
  }))  
}
variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}

# variable "vpc_id" {
#   description = "VPC ID"
#   type = string
# } 
#variable "public_subnets_cidr_blocks" {
#   description = "List of CIDR blocks for public subnets"
#   type        = list(string)
#   default     = [""]

# }

# variable "availability_zones" {
#   description = "List of availability zones for the VPC"
#   type        = list(string)
#   default     = [""]

# }

# variable "map_public_ip_on_launch" {
#   description = "Map public IP on launch for public subnets"
#   type        = bool
#   default     = true

# }

# variable "map_public_ip_on_private_subs" {
#   description = "Map public IP on launch for public subnets"
#   type        = bool
#   default     = false

# }

######## private subnets #########



# variable "create_private_subnets" {
#   description = "Bool to create private subnets"
#   type = bool
#   default = true
# }

# variable "private_subnets_cidr_blocks" {
#   description = "List of private subnets CIDR blocks"
#   type        = list(string)
#   default     = [""]
# }

