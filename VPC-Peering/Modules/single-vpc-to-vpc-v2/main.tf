data "aws_caller_identity" "peer" {
}

### Requesters/Source side of the connection ###
resource "aws_vpc_peering_connection" "this_connection" {

 for_each = var. vpc_peering_connection
  peer_owner_id =   data.aws_caller_identity.peer.account_id
  peer_vpc_id   =   each.value.peer_vpc_id ## Accepter VPC ID
  vpc_id        =   each.value.vpc_id      ## Requester VPC ID
  auto_accept   =   each.value.auto_accept ## Auto accept the connection
  peer_region   =   each.value.peer_region ## Destination VPC region

  tags = var.tags
 
}


### Accepters/Destination side of the connection ###
resource "aws_vpc_peering_connection_accepter" "dest_peer" {
  for_each = aws_vpc_peering_connection.this_connection
  vpc_peering_connection_id =  each.value.id ## VPC Peering Connection ID
  auto_accept               =  each.value.auto_accept ## Auto accept the connection



tags = var.tags


}