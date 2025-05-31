variable "environment" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
  
}

variable "source_region" {
  description = "The AWS region for the source VPC"
  type        = string
}

variable "dest_region" {
  description = "The AWS region for the destination VPC"
  type        = string
  
}


### Source VPC Variables ###


variable "source_vpc_name" {
  description = "Name for the source VPC"
  type        = string
  
}

variable "source_cidr" {
  description = "CIDR block for the destination VPC"
  type        = string
}

variable "source_pub_sub_cidr" {
  description = "CIDR block for the public subnet"
  type        = string 
}

variable "source_subnet1_cidr" {
  description = "CIDR block for the first destination subnet"
  type        = string
  
} 

variable "source_subnet1_name" {
  description = "Name for the first destination subnet"
  type        = string
  
}

variable "source_subnet1_az" {
  description = "Availability Zone for the first destination subnet"
  type        = string  
  
}

variable "source_subnet2_name" {
  description = "Name for the second destination subnet"
  type        = string
  
}

variable "source_subnet2_cidr" {
  description = "CIDR block for the second destination subnet"
  type        = string
  
}


variable "source_subnet2_az" {
  description = "Availability Zone for the second destination subnet"
  type        = string
  
}

variable "source_rt_name" {
  description = "Name for the destination route table"
  type        = string  
  
}

### Destination VPC Variables ###

variable "dest_vpc_name" {
  description = "Name for the source VPC"
  type        = string
  
}
variable "dest_cidr" {
  description = "CIDR block for the destination VPC"
  type        = string
}


variable "dest_subnet1_cidr" {
  description = "CIDR block for the first destination subnet"
  type        = string
  
} 

variable "dest_subnet1_name" {
  description = "Name for the first destination subnet"
  type        = string
  
}

variable "dest_subnet1_az" {
  description = "Availability Zone for the first destination subnet"
  type        = string  
  
}

variable "dest_subnet2_name" {
  description = "Name for the second destination subnet"
  type        = string
  
}

variable "dest_pub_sub_cidr" {
  description = "CIDR block for the public subnet"
  type        = string 
}

variable "dest_subnet2_cidr" {
  description = "CIDR block for the second destination subnet"
  type        = string
  
}


variable "dest_subnet2_az" {
  description = "Availability Zone for the second destination subnet"
  type        = string
  
}

variable "dest_rt_name" {
  description = "Name for the destination route table"
  type        = string  
  
}