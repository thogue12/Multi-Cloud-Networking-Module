##########################################################################
# VPC Configuration
##########################################################################


resource "aws_vpc" "this_vpc" {
  # count = var.create_vpc ? 1: 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      Name = "${var.name}-vpc"
    },
    var.tags
  )
}