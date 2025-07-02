data "aws_caller_identity" "peer" {}

### ------------ VPC A -> VPC B ------------ ###
resource "aws_vpc_peering_connection" "connection_a" {

  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = aws_vpc.vpc_b.id  ## Accepter VPC ID
  vpc_id        = aws_vpc.vpc_a.id  ## Requester VPC ID
  auto_accept   = false
  peer_region   = var.aws_region  

  tags = {
    Name = "vpc a -> vpc b"
  }

  depends_on = [ aws_vpc.vpc_a, aws_vpc.vpc_b ]
}


### Accepters/Destination side of the connection ###
resource "aws_vpc_peering_connection_accepter" "vpc_a_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.connection_a.id
  auto_accept               = true



  tags = {
    Side = "Accepter"
    Name = "vpc b -> vpc a"
  }

  depends_on = [ aws_vpc.vpc_a, aws_vpc.vpc_b ]
}


### ------------ VPC A -> VPC C ------------ ###
resource "aws_vpc_peering_connection" "connection_b" {

  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = aws_vpc.vpc_c.id  ## Accepter VPC ID
  vpc_id        = aws_vpc.vpc_a.id  ## Requester VPC ID
  auto_accept   = false
  peer_region   = var.aws_region  

  tags = {
    Name = "vpc a -> vpc c"
  }

  depends_on = [ aws_vpc.vpc_a, aws_vpc.vpc_c ]
}


### Accepters/Destination side of the connection ###
resource "aws_vpc_peering_connection_accepter" "vpc_c_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.connection_b.id
  auto_accept               = true



  tags = {
    Side = "Accepter"
    Name = "vpc c -> vpc a"
  }

  depends_on = [ aws_vpc.vpc_a, aws_vpc.vpc_c ]
}




### ------------ VPC C -> VPC B ------------ ###
resource "aws_vpc_peering_connection" "connection_c" {

  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = aws_vpc.vpc_b.id  ## Accepter VPC ID
  vpc_id        = aws_vpc.vpc_c.id  ## Requester VPC ID
  auto_accept   = false
  peer_region   = var.aws_region  

  tags = {
    Name = "vpc c -> vpc b"
  }

  depends_on = [ aws_vpc.vpc_a, aws_vpc.vpc_c ]
}


### Accepters/Destination side of the connection ###
resource "aws_vpc_peering_connection_accepter" "vpc_b_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.connection_c.id
  auto_accept               = true



  tags = {
    Side = "Accepter"
    Name = "vpc b -> vpc c"
  }

  depends_on = [ aws_vpc.vpc_b, aws_vpc.vpc_c ]
}