variable "name" {
  description = "Global name"
  type        = string
  
}

# variable "security_group_id" {
#   description = "Security Group ID"
#   default     = aws_security_group.this_sg.id
  
# }


variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
  
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  
}

variable "security_group_description" {
  description = "description for the security group"
  type        = string
  
}


variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({

    from_port                = number
    to_port                  = number
    protocol                 = string
    description              = string
    cidr_blocks              = optional(list(string), [])
  }))
}




