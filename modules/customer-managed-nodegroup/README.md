# Module for Self-Managed Node Groups for EKS

This module creates only the node group, not EKS.

Idea is to create another stand-alone node group in a separate VPC/AWS account (with peering to the VPC where EKS is created), to join the created EKS.

Usage example:

```
module "nodegroup" {
  source = "../modules/customer-managed-nodegroup"

  cluster_name          = data.terraform_remote_state.eks.outputs.cluster_name
  nodegroup_name        = var.nodegroup_name
  cluster_endpoint      = data.terraform_remote_state.eks.outputs.endpoint
  cert_data             = data.terraform_remote_state.eks.outputs.kubeconfig-certificate-authority-data
  ssh_worker_key        = var.ssh_worker_key
  vpc_id                = data.terraform_remote_state.network.outputs.second_vpc_id
  worker_subnet_ids     = data.terraform_remote_state.network.outputs.second_vpc_private_subnet_ids
  instance_profile_name = local.instance_profile_name
  control_plane_sg_id   = data.terraform_remote_state.eks.outputs.eks_security_group_id
  peering_vpc_cidr      = data.terraform_remote_state.network.outputs.main_vpc_cidr
}
```

Note that, the `instance_profile_name` isn't an output of any terraform module, so in order to get this, you can do a hack like:

```
# in the shell script, run AWS CLI to get profile name by IAM role name and return a JSON with jq
data "external" "instance_profile" {
  program = ["bash", "get-instance-profile-by-iam-role-name.sh"]
}

locals {
  instance_profile_name = data.external.instance_profile.result.profile_name
}
```
