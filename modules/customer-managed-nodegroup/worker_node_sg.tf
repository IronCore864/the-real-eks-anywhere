resource "aws_security_group" "worker" {
  name        = "${var.nodegroup_name}_sg"
  description = "Security group for all nodes in the cluster."
  vpc_id      = var.vpc_id

  lifecycle {
    ignore_changes = [ingress]
  }

  tags = {
    "Name"                   = "${var.nodegroup_name}_sg"
    "kubernetes.io/cluster/" = var.cluster_name
  }
}

resource "aws_security_group_rule" "workers_egress_internet" {
  description       = "Allow nodes all egress to the Internet."
  protocol          = "-1"
  security_group_id = aws_security_group.worker.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "workers_ingress_self" {
  description       = "Allow node to communicate with each other."
  protocol          = "-1"
  security_group_id = aws_security_group.worker.id
  cidr_blocks       = [var.peering_vpc_cidr]
  from_port         = 0
  to_port           = 65535
  type              = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_cluster" {
  description              = "Allow workers pods to receive communication from the cluster control plane."
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = var.control_plane_sg_id
  from_port                = 0
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "self" {
  description       = "Allow workers pods to receive communication from the cluster control plane."
  protocol          = "-1"
  security_group_id = aws_security_group.worker.id
  self              = true
  from_port         = 0
  to_port           = 0
  type              = "ingress"
}
