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


#####################################
# Public Route Tables
#####################################

variable "public_route_tables" {
  description = "Map of public route tables"
  type = map(object({
    vpc_id = string
    region = optional(string, null) # Optional region for the route table

  }))
}


#####################################
# Public Routes 
#####################################
variable "public_routes" {
  description = "Dynamically create routes for the route table"
  type = map(object({
    type = optional(string, "public") # Default to public if not specified
    route_table_id = string
    destination_cidr_block = string
    gateway_id = optional(string, null)
    nat_gateway_id = optional(string, null)
    peering_connection_id = optional(string, null)
    transit_gateway_id = optional(string, null)

  }))
}

#####################################
# Public Route Table Associations
#####################################
variable "public_route_table_associations" {
  description = "Map of public route table associations"
  type = map(object({
    route_table_id = string
    subnet_id = string
  }))
}



#####################################
# Private Route Tables
#####################################

variable "private_route_tables" {
  description = "Map of private route tables"
  type = map(object({
    vpc_id = string
    region = optional(string, null) # Optional region for the route table

  }))
  
}

#####################################
# Private Route Table Associations
#####################################

variable "private_route_table_associations" {
  description = "Map of private route table associations"
  type =map(object({
    route_table_id = string
    subnet_id = string
  }))
}

#####################################
# Private Routes 
#####################################
variable "private_routes" {
  description = "Dynamically create routes for the route table"
  type = map(object({
    type = optional(string, "public") # Default to public if not specified
    route_table_id = optional(string, null)
    destination_cidr_block = string
    gateway_id = optional(string, null)
    nat_gateway_id = optional(string, null)
    peering_connection_id = optional(string, null)
    transit_gateway_id = optional(string, null)

  }))
}


##############################################
# Old Variables for Public and Private Subnets
##############################################

# variable "public_subnets" {
#   description = "List of IDs of public subnets"
#   type = list(string)
# }

# variable "private_subnets" {
#   description = "List of IDs of private subnets"
#     type = list(string)
  
# }
# variable "create_public_subnets" {
#   description = "value of create_public_subnets local variable"
#   type = string

# }

# variable "create_private_subnets" {
#   description = "value of create_private_subnets local variable"
#   type = string
  
# }


# variable "vpc_id" {
#   description = "VPC ID"
#   type = string
# }

# variable "igw_id" {
#   description = "Internet Gateway ID"
#   type = string
# }

# variable "nat_id" {
#   description = "NAT Gateway ID"
#   type = string
# }
# variable "public_subnets_cidr_blocks" {
#   description = "List of CIDR blocks for public subnets"
#   type        = list(string)
#   default     = [""]

# }
# variable "private_subnets_cidr_blocks" {
#   description = "List of CIDR blocks for private_ subnets"
#   type        = list(string)
#   default     = [""]

# }