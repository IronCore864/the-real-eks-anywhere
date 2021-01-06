resource "aws_launch_template" "workers_launch_template" {
  name_prefix = "${var.nodegroup_name}_worker_lt"

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [aws_security_group.worker.id]
  }

  image_id = data.aws_ami.eks_worker.id

  instance_type = var.worker_instance_type

  key_name = var.ssh_worker_key

  user_data = base64encode(data.template_file.userdata.rendered)

  ebs_optimized = false

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }

  monitoring {
    enabled = true
  }

  placement {
    tenancy = "default"
  }

  block_device_mappings {
    device_name = data.aws_ami.eks_worker.root_device_name

    ebs {
      volume_size           = var.ebs_volume_size
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      "Name" = "${var.cluster_name}-eks_asg"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
