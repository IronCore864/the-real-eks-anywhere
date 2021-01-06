module "cluster" {
  source = "../modules/eks-cluster-with-managed-nodegroup"

  cluster_name      = var.cluster_name
  nodegroup_name    = var.nodegroup_name
  vpc_id            = var.vpc_id
  worker_subnet_ids = var.worker_subnet_ids
}
