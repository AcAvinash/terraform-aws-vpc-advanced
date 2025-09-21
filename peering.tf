resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  auto_accept   = true
  # peer_vpc_id is the VPC ID of the accepter VPC.
  peer_vpc_id   = aws_vpc.main.id
  # Requester VPC ID.

  vpc_id        = var.requestor_vpc_id
}

resource "aws_route" "default_route" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = var.default_route_table_id
  destination_cidr_block    = var.cidr_block
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  #depends_on                = [aws_route_table.testing]
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.default_vpc_cidr
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  #depends_on                = [aws_route_table.testing]
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = var.default_vpc_cidr
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  #depends_on                = [aws_route_table.testing]
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = var.default_vpc_cidr
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  #depends_on                = [aws_route_table.testing]
}