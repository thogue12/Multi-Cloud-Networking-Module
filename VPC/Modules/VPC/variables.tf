

variable "name" {
  description = "Global name for all resources"
  type = string
  default = ""
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = ""
}

variable "enable_dns_support" {
  description = "Enable DNS Support for VPC"
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  description = "Enable Hostnames for VPC"
  type = bool
  default = true
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type = map(string)
  default = {}
}