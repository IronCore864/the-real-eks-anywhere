module "cluster" {
  source = "../modules/eks-cluster-with-managed-nodegroup"

  cluster_name      = var.cluster_name
  nodegroup_name    = var.nodegroup_name
  vpc_id            = data.terraform_remote_state.network.outputs.main_vpc_id
  worker_subnet_ids = data.terraform_remote_state.network.outputs.main_vpc_private_subnet_ids
}
