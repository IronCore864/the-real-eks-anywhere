data "aws_caller_identity" "main" {}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.main_vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = data.aws_caller_identity.main.account_id
  peer_region   = "eu-central-1"
  auto_accept   = false
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
}
