# official EKS AMI
data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.k8s_version}-v*"]
  }

  most_recent = true

  # owner ID of the official AMI
  owners = ["602401143452"]
}

resource "aws_autoscaling_group" "worker_asg" {
  vpc_zone_identifier = var.worker_subnet_ids

  name                 = "${var.nodegroup_name}-asg"
  min_size             = var.min_worker_node_number
  desired_capacity     = var.desired_worker_node_number
  max_size             = var.max_worker_node_number
  termination_policies = ["OldestInstance"]

  launch_template {
    id = aws_launch_template.workers_launch_template.id
    # using latest launch template version
    version = "$Latest"
  }

  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${var.cluster_name}-${var.nodegroup_name}-Node"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "kubernetes.io/cluster/${var.cluster_name}"
        "value"               = "1"
        "propagate_at_launch" = true
      },
      # for the ALB https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
      {
        "key"                 = "kubernetes.io/role/elb"
        "value"               = "owned"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "k8s.io/cluster-autoscaler/enabled"
        "value"               = "true"
        "propagate_at_launch" = false
      },
      {
        "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
        "value"               = "owned"
        "propagate_at_launch" = false
      },
      {
        "key"                 = "k8s.io/cluster-autoscaler/node-template/resources/ephemeral-storage"
        "value"               = "100Gi"
        "propagate_at_launch" = false
      },
    ]
  )
}
