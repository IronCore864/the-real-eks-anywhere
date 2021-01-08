output "cluster_name" {
  value = module.cluster.cluster_name
}

output "endpoint" {
  value = module.cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = module.cluster.kubeconfig-certificate-authority-data
}

output "eks_security_group_id" {
  value = module.cluster.security_group_id
}

output "worker_node_role_name" {
  value = module.cluster.worker_node_role_name
}
