resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.project_name}-scale-out"
  autoscaling_group_name = aws_autoscaling_group.this.name

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown           = 300
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.project_name}-scale-in"
  autoscaling_group_name = aws_autoscaling_group.this.name

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown           = 300
}
