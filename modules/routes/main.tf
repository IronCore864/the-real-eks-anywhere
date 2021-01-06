locals {
  private_subnet_cidr_to_nat_map = zipmap(var.private_subnet_cidr_list, var.nat_ids)
  # to bypass dynamic keys in for_each
  private_subnet_cidr_to_id_map = zipmap(var.private_subnet_cidr_list, var.private_subnet_ids)
  public_subnet_cidr_to_id_map  = zipmap(var.public_subnet_cidr_list, var.public_subnet_ids)
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public_subnet" {
  for_each = local.public_subnet_cidr_to_id_map

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = local.private_subnet_cidr_to_nat_map

  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value
  }
  route {
    cidr_block                = var.peering_vpc_cidr
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "private_subnet" {
  for_each = local.private_subnet_cidr_to_id_map

  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}
