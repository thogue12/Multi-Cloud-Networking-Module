terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket1237546"
    key          = "dev-vpc-peering-terraform-state.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
