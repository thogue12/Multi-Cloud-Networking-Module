data "aws_caller_identity" "peer" {
  provider = aws.us-east
}

### Requesters/Source side of the connection ###
resource "aws_vpc_peering_connection" "this_connection" {
  provider = aws.us-east
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = aws_vpc.destination_vpc.id  ## Accepter VPC ID
  vpc_id        = aws_vpc.source_vpc.id  ## Requester VPC ID
  auto_accept   = false
  peer_region   = var.dest_region  ## Destination VPC region

  tags = {
    Name = "east -> west"
  }

  depends_on = [ aws_vpc.source_vpc, aws_vpc.destination_vpc ]
}


### Accepters/Destination side of the connection ###
resource "aws_vpc_peering_connection_accepter" "dest_peer" {
  provider = aws.us-west  
  vpc_peering_connection_id = aws_vpc_peering_connection.this_connection.id
  auto_accept               = true



  tags = {
    Side = "Accepter"
    Name = "west -> east"
  }

  depends_on = [ aws_vpc.source_vpc, aws_vpc.destination_vpc ]
}
