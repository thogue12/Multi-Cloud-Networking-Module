###########################################################################
# VPC Configuration
##########################################################################



resource "aws_vpc" "this_vpc" {
  for_each             = var.vpc_attributes
  # provider = each.value.region == "us-east-1" ? aws.us-east : aws.us-west
  cidr_block           = each.value.cidr_block
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  region               = each.value.region

  tags = merge(
    {
       Name = lookup(each.value, "name", "-${each.key}") 
          },
    var.tags
  )
}

