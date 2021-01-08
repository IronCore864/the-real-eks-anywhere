# Terraform Module for EKS

This module creates an EKS cluster in a given VPC, as well as a managed node group in the same VPC.

Usage example:

```
module "cluster" {
  source = "./path/to/modules/eks-cluster-with-managed-nodegroup"

  cluster_name      = var.cluster_name
  nodegroup_name    = var.nodegroup_name
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  worker_subnet_ids = data.terraform_remote_state.network.outputs.vpc_private_subnet_ids
}
```
