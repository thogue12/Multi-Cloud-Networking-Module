variable "aws_region" {
  description = "AWS region where the VPCs will be created"
  type        = string
  default     = "us-east-1"

}
variable "environment" {
  description = "Environment for the VPCs (e.g., dev, staging, prod)"
  type        = string
  
}

### VPC Variables ###
variable "vpc_a_cidr" {
  description = "CIDR block for VPC A"
  type        = string
  
}
variable "vpc_b_cidr" {
  description = "CIDR block for VPC B"
  type        = string
  
}
variable "vpc_c_cidr" {
  description = "CIDR block for VPC C"
  type        = string
  
}
variable "vpc_a_name" {
  description = "Name for VPC A"
  type        = string
}
variable "vpc_b_name" {
  description = "Name for VPC B"
  type        = string
}
variable "vpc_c_name" {
  description = "Name for VPC C"
  type        = string
}

### Subnet Variables ###

### Subnet CIDR blocks for each Subnet ###
variable "vpc_a_subnet_1_cidr" {
  description = "CIDR block for VPC A Subnet 1"
  type        = string
}
variable "vpc_b_subnet_1_cidr" {
  description = "CIDR block for VPC B Subnet 1"
  type        = string
}
variable "vpc_c_subnet_1_cidr" {
  description = "CIDR block for VPC C Subnet 1"
  type        = string
}

### Subnet Availability Zones for each Subnet ###

variable "vpc_a_subnet_1_availability_zone" {
  description = "Availability Zone for VPC A Subnet 1"
  type        = string
  
}

variable "vpc_b_subnet_1_availability_zone" {
  description = "Availability Zone for VPC B Subnet 1"
  type        = string
  
}
variable "vpc_c_subnet_1_availability_zone" {
  description = "Availability Zone for VPC C Subnet 1"
  type        = string
  
}