/**
 * ============================================================================
 * APPLICATION LOAD BALANCER
 * ----------------------------------------------------------------------------
 * Internet-facing ALB that distributes HTTP traffic to the Auto Scaling Group.
 * ============================================================================
*/

resource "aws_autoscaling_group" "web" {
  name              = "${var.project_name}-asg"
  min_size          = 2
  desired_capacity  = 2
  max_size          = 6
  health_check_type = "ELB"

  vpc_zone_identifier = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  target_group_arns = [
    aws_lb_target_group.web.arn
  ]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web"
    propagate_at_launch = true
  }
}
