terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "6.0.0-beta2"
      configuration_aliases = [aws.us-east, aws.us-west]
    }
  }

}
provider "aws" {
  region = local.region
  alias  = "us-west"
}

provider "aws" {
  region = local.region_2
  alias  = "us-east"
}
##