resource "aws_security_group_rule" "allow_vpc2" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.second_vpc_cidr]
  security_group_id = data.terraform_remote_state.eks.outputs.eks_security_group_id
}
