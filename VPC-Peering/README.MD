## Point of this project 
##  Overview

This project enables secure VPC peering between AWS regions using modular Terraform code. It includes:

- Reusable modules for VPC creation, peering, and security group management
- Environment-specific configurations (dev, test, prod) with isolated state files
- GitHub Actions workflow implementing a DevSecOps pipeline with:
  - Terraform formatting, linting, and validation
  - `tfsec` and `Trivy` for static security analysis
  - `tflint` for best practices
  - Plan/apply with GitHub environment approvals
- SSM-based private connectivity testing

Built to demonstrate infrastructure-as-code principles, secure automation, and scalable environment design in a multi-region setup.


## Modules Directory:
    - Module 1 = A single VPC Peering with one other VPC


## Important Note: To enable private IPv4 traffic between instances in peered VPCs, you must add a route to the route tables associated with the subnets for both instances. The route destination is the CIDR block (or portion of the CIDR block) of the peer VPC and the target is the ID of the VPC peering connection. ## 

##  Within each module:
    - VPC:
        - VPC CIDR
        - 2 Private Subnets
        - 1 Public Subnet (for Internet Gateway--- OR LEARN HOW TO USE SSM for better security
        using SSM will eliminate the need for, publicIPs, and NAT GW)
        - 2 different AZs
    - Route Table
        - Route to the peered VPC(s)
        - Subnet Associations
        - NAT gateway association
    - NAT Gateway (maybe)
    - Internet Gateway(maybe)
    - EC2 instance
        - Get an EC2 instance with SSM agent pre-installed
    - Security Group:
        - allow ICMP for Ping: make sure to have -1 for the ports
            - cidr block [ should be the vpc youre trying to reach]
        - allow SSH so you can get into the VM

    - Peering Connection:
        - The oposite VPC should have a similar or same setup with different CIDRs and DIFFERENT REGIONS!!
        - Ensure this VPC also has a peering connection to the source VPC
            - Check the Route Table
    
    - IAM:
        - Create a IAM policy for SSM access
        - Create a role
            - attach the IAM policy to that role
        - Create a role document
        - Create a role profile to reference


##  GitHub Actions:
    - Create a workflow that builds the AWS Resources with Terraform
    - Create a DevSecOps workflow:
        - Terraform validate ---------- Syntax and basic config validation
        - Terraform plan   ------------ Shows the execution plan and helps catch issues early
        - Terraform fmt    ------------ Enforces standard formatting
        - Tflint ---------------------- Linting and deeper static analysis
        - Tfsec   --------------------- Terraform security checks (deep, provider-aware)
        - Trivy IaC ------------------- IaC misconfig checks


## How to use this module:

### Prerequisites
- Terraform 1.11.0+
- AWS CLI configured
- GitHub repository secrets set for GitHub Actions (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, etc.)

