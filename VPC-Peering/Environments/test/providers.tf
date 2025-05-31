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
  alias  = "us-east"
  region = var.source_region
}

provider "aws" {
  alias  = "us-west"
  region = var.dest_region
}