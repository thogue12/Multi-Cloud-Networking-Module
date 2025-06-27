########################################################################
# EC2 Variables
########################################################################

variable "instance_attributes" {
  description = "Map of instances to create"
  type = map(object({
    instance_type = string # t2.micro
    iam_instance_profile = optional(string)
    subnet_id = string
    vpc_security_group_ids = optional(list(string))

  }))
}

variable "tags" {
  description = "tags to apply"
 type        = map(string)
}
variable "name" {
  
}