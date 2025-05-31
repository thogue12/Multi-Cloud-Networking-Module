## Point of this project 

I want to create for myself an all encompassing Multi Cloud Networking Module
   this one will act as project number 1 VPC Peering:

## Setup

Environments Directory:
    - Dev
    - Test
    - Prod
-- Each ENV will have its own terraform backend for state isolation
-- Each ENV will there own terrafrom.tfvars file and providers file

## -- Modules Directory:
    - Module 1 = A single VPC Peering with one other VPC
    - Module 2 = 3 VPCs Peering with 3 other VPCs

## ---- Important Note: To enable private IPv4 traffic between instances in peered VPCs, you must add a route to the route tables associated with the subnets for both instances. The route destination is the CIDR block (or portion of the CIDR block) of the peer VPC and the target is the ID of the VPC peering connection.---- ## 

## -- Within each module:
    - VPC:
        - VPC CIDR
        - 2 Private Subnets
        - 1 Public Subnet (for Internet Gateway--- OR LEARN HOW TO USE ENDPOINTS FOR SECURITY)
        - 2 different AZs
    - Route Table
        - Route to the peered VPC(s)
        - Subnet Associations
        - NAT gateway association
    - NAT Gateway
    - Internet Gateway(maybe)
    - EC2 instance
    - Security Group:
        - allow ICMP for Ping: make sure to have -1 for the ports
            - cidr block [ should be the vpc youre trying to reach]
        - allow SSH so you can get into the VM

    - Peering Connection:
        - The oposite VPC should have a similar or same setup with different CIDRs and DIFFERENT REGIONS!!
        - Ensure this VPC also has a peering connection to the source VPC
            - Check the Route Table

## -- GitHub Actions:
    - Create a workflow that builds the AWS Resources with Terraform
    - Create a DevSecOps workflow:
        - Inlcude Terraform Linting
        - Terraform Security
        - Terraform init, plan, apply and destroy
    - I want to have a github actions workflwo dedicated to each module I create
    - 
