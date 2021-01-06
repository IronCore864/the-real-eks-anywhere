# Terraform Module for EKS

## Usage

```
module "cluster" {
  source = "./path/to/modules/eks-cluster-with-managed-nodegroup"

  cluster_name      = var.cluster_name
  vpc_id            = var.vpc_id
  worker_subnet_ids = var.worker_subnet_ids
}
```
