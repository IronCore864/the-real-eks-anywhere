module "nodegroup" {
  source = "../modules/customer-managed-nodegroup"

  cluster_name          = var.cluster_name
  nodegroup_name        = var.nodegroup_name
  cluster_endpoint      = var.cluster_endpoint
  cert_data             = var.cluster_cert_data
  ssh_worker_key        = var.ssh_worker_key
  vpc_id                = var.vpc_id
  worker_subnet_ids     = var.worker_subnet_ids
  instance_profile_name = var.instance_profile_name
  control_plane_sg_id   = var.control_plane_sg_id
  peering_vpc_cidr      = var.peering_vpc_cidr
}
