
variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}

variable "name" {
  description = "Global name for all resources"
  type        = string
  
}
variable "eip" {
  description = "EIP for NAT Gateway"
  type        = map(object({
    region = optional(string)
    tags = optional(map(string)) # Optional tags for the EIP
    domain = optional(string) # Indicates if this EIP is for use in VPC (vpc)
    instance_id = optional(string) # EC2 instance ID for EIP association
    network_interface_id = optional(string) # Network interface ID for EIP association

  }))
  
}

variable "nat_gateway" {
  description = "Map of NAT Gateway configurations"
  type = map(object({
    allocation_id = string
    subnet_id     = string
    tags = optional(map(string)) # Optional tags for the NAT Gateway
  }))
}

variable "internet_gateway" {
  description = "Map of Internet Gateway configurations"
  type = map(object({
    vpc_id = string
    tags = optional(map(string)) # Optional tags for the Internet Gateway
    
  }))
  
}












