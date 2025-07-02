###################################################################
# VPC Peering Variables
###################################################################

variable "vpc_peering_connection" {
  description = "Map of VPC Peering Connection attributes"
  type = map(object({
    name = optional(string)
    vpc_id      = string # Requester VPC ID
    peer_vpc_id  = string # Accepter VPC ID
    peer_region      = optional(string) # Destination VPC region
    auto_accept      = bool
  }))
}

variable "vpc_peering_accepter" {
  description = "Map of VPC Peering Accepter attributes"
  type = map(object({
    vpc_peering_connection_id = string
    auto_accept               = bool
    name  = optional(string)
  }))
}

variable "tags" {
  description = "Map of tags to apply to the VPC Peering Connection and Accepter"
  type        = map(string)
  
}