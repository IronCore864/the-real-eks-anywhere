output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  value = [
    for r in aws_subnet.public :
    r.id
  ]
}

output "private_subnet_ids" {
  value = [
    for r in aws_subnet.private :
    r.id
  ]
}

output "private_subnet_az_id_map" {
  value = {
    for k, v in var.private_subnets :
    k => aws_subnet.private[k].id
  }
}

output "nat_ids" {
  value = [
    for r in aws_nat_gateway.main :
    r.id
  ]
}
