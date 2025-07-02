#########################################################
# Topics I'm going to explore in this module
#########################################################


### Conditional logic
    - Conditionally create VPC
    - Based off the bool the subsequent resources associated to the VPC will be created or not
    - Create IGW based off of bool
        - That IGW should then have logic in a locals variable, that says. "if the vpc bool == true and the public route table == true then create a route to the internet gateway" 
            - example logic:
                locals{
                    create_route_to_igw = var.create_vpc && var.create_igw && local.create_public_route_table
                }
    - Create NAT Gateway based off of bool
        - That NAT should then have logic in a locals variable, that says. "if the vpc bool == true and the private subnet creation == true then create a route to the NAT gateway" 
            - example logic:
                locals{
                    create_route_to_nat = var.create_vpc && var.create_igw && local.create_private_route_table
                }
### Count
    - Couple conditional logic with the Count meta argument
        - Based off of the conditions bool will determine how many of the VPCs are created

### Dynamic Resource Allocation
    - Based on how many VPCs are created will result in how many Private, Public Subnets are created
    - Along with Route tables for Public and Private subs
    - Internet Gateway
    - NAT Gateway

### Dynamic CIDR Blocks
    - Use one of the Terraform functions to create CIDRs for subnets based off of the VPC created.

### Dynamic Resource Creation:
    - allow the user to specify how many of a given resource is created
    -

### map(string) variables for tags with string interpolation
    - Name
    - Environment
        - example:
            variable "tags"{
                description = "tags for each resource"
                type = map(string)
                default = {}
            }