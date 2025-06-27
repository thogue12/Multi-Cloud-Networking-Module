variable "name" {
  description = "Global name"
  type        = string
  
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
  
}


variable "security_groups" {
  description = "Map of secruity groups to create"
  type = map(object({
    vpc_id = string 
    description = string
  }))
}

variable "ingress_rules" {
  description = "Map of ingress rules"
  type = map(object({
    description = optional(string)
    type = string
    from_port = number
    protocol = string
    to_port = number
    cidr_blocks = list(string)
    security_group_id = string

  }))
}
  
variable "egress_rules" {
  description = "Map of ingress rules"
  type = map(object({
    security_group_id = string

  }))
}









































# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
  
# }

# variable "security_group_description" {
#   description = "description for the security group"
#   type        = string
  
# }


# variable "ingress_rules" {
#   description = "List of ingress rules"
#   type = list(object({

#     from_port                = number
#     to_port                  = number
#     protocol                 = string
#     description              = string
#     cidr_blocks              = optional(list(string), [])
#   }))
# }




