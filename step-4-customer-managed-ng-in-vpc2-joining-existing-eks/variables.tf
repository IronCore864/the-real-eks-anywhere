# mandatory variables
variable "nodegroup_name" {
  type = string
}

variable "ssh_worker_key" {
  description = "the ssh key pair used to ssh into the worker node ec2 instance, must be already in the account"
  type        = string
}
