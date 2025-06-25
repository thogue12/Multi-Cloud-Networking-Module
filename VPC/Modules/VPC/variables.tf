

variable "name" {
  description = "Global name for all resources"
  type = string
  default = ""
}


variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}

variable "vpc_attributes" {
  description = "Additional attributes for the VPC"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    region               = string
  }))
  
}

# variable "vpc_cidr" {
#   description = "VPC CIDR"
#   type = string
#   default = ""
# }

# variable "enable_dns_support" {
#   description = "Enable DNS Support for VPC"
#   type = bool
#   default = true
# }

# variable "enable_dns_hostnames" {
#   description = "Enable Hostnames for VPC"
#   type = bool
#   default = true
# }