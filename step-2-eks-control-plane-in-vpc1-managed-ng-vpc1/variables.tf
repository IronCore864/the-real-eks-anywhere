variable "cluster_name" {
  type = string
}

variable "nodegroup_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "worker_subnet_ids" {
  type = list(any)
}
