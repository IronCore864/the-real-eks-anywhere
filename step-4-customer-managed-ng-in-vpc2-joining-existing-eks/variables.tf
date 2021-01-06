# mandatory variables
variable "cluster_name" {
  type = string
}

variable "nodegroup_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_cert_data" {
  type = string
}

variable "vpc_id" {
  description = "The existing VPC, in this case it is the DEV-INFRA VPC in DEV account"
}

variable "worker_subnet_ids" {
  type        = list(any)
  description = "the subnets where to deploy EKS"
}

variable "ssh_worker_key" {
  description = "the ssh key pair used to ssh into the worker node ec2 instance, must be already in the account"
  type        = string
}

variable "instance_profile_name" {
  description = "the IAM instance profile role name from existing node groups"
  type        = string
}

variable "control_plane_sg_id" {
  type = string
}

variable "peering_vpc_cidr" {
  type = string
}
