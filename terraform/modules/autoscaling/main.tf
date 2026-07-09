resource "aws_autoscaling_group" "this" {
  name = "${var.project_name}-asg"

  vpc_zone_identifier = var.private_subnet_ids

  desired_capacity      = var.desired_capacity
  capacity_rebalance    = true
  protect_from_scale_in = false
  min_size              = var.min_size
  max_size              = var.max_size

  health_check_type         = "ELB"
  health_check_grace_period = 300
  default_instance_warmup   = 300
  target_group_arns         = [var.target_group_arn]

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }

  termination_policies = [
    "OldestLaunchTemplate",
    "Default"
  ]

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
