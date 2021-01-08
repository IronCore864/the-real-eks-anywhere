output "main_vpcprivate_subnet_az_id_map" {
  value = module.vpc1.private_subnet_az_id_map
}

output "main_vpc_id" {
  value = module.vpc1.vpc_id
}

output "main_vpc_cidr" {
  value = var.main_vpc_cidr
}

output "main_vpc_private_subnet_ids" {
  value = module.vpc1.private_subnet_ids
}

output "second_vpc_id" {
  value = module.vpc2.vpc_id
}

output "second_vpc_cidr" {
  value = var.second_vpc_cidr
}

output "second_vpc_private_subnet_ids" {
  value = module.vpc2.private_subnet_ids
}
