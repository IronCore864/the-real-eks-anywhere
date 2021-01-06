module "vpc1" {
  source = "../modules/networking"

  vpc_cidr_block  = var.main_vpc_cidr
  vpc_name        = var.main_vpc_name
  public_subnets  = var.main_vpc_public_subnets_az_cidr_map
  private_subnets = var.main_vpc_private_subnets_az_cidr_map
}

module "vpc2" {
  source = "../modules/networking"

  vpc_cidr_block  = var.second_vpc_cidr
  vpc_name        = var.second_vpc_name
  public_subnets  = var.second_vpc_public_subnets_az_cidr_map
  private_subnets = var.second_vpc_private_subnets_az_cidr_map
}

module "vpc-peering" {
  depends_on = [module.vpc1, module.vpc2]
  source     = "../modules/vpc-peering"

  main_vpc_id = module.vpc1.vpc_id
  peer_vpc_id = module.vpc2.vpc_id
}

module "vpc1_routes" {
  depends_on = [module.vpc1, module.vpc2, module.vpc-peering]
  source     = "../modules/routes"

  vpc_id                    = module.vpc1.vpc_id
  internet_gateway_id       = module.vpc1.internet_gateway_id
  public_subnet_ids         = module.vpc1.public_subnet_ids
  private_subnet_ids        = module.vpc1.private_subnet_ids
  nat_ids                   = module.vpc1.nat_ids
  vpc_peering_connection_id = module.vpc-peering.vpc_peering_connection_id
  peering_vpc_cidr          = var.second_vpc_cidr
  public_subnet_cidr_list   = keys(var.main_vpc_public_subnets_az_cidr_map)
  private_subnet_cidr_list  = keys(var.main_vpc_private_subnets_az_cidr_map)
}

module "vpc2_routes" {
  depends_on = [module.vpc1, module.vpc2, module.vpc-peering]
  source     = "../modules/routes"

  vpc_id                    = module.vpc2.vpc_id
  internet_gateway_id       = module.vpc2.internet_gateway_id
  public_subnet_ids         = module.vpc2.public_subnet_ids
  private_subnet_ids        = module.vpc2.private_subnet_ids
  nat_ids                   = module.vpc2.nat_ids
  vpc_peering_connection_id = module.vpc-peering.vpc_peering_connection_id
  peering_vpc_cidr          = var.main_vpc_cidr
  public_subnet_cidr_list   = keys(var.second_vpc_public_subnets_az_cidr_map)
  private_subnet_cidr_list  = keys(var.second_vpc_private_subnets_az_cidr_map)
}
