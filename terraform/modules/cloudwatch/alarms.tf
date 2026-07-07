#########################################
# High CPU Utilization
#########################################

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name        = "${var.project_name}-high-cpu"
  alarm_description = "Average CPU utilization is above 70%."

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"

  period              = 300
  evaluation_periods  = 2
  threshold           = 70
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = var.tags
}

#########################################
# EC2 Status Check Failed
#########################################

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name        = "${var.project_name}-status-check-failed"
  alarm_description = "EC2 instance status check failed."

  namespace   = "AWS/EC2"
  metric_name = "StatusCheckFailed"

  statistic = "Maximum"

  period              = 60
  evaluation_periods  = 2
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = var.tags
}

#########################################
# ALB HTTP 5XX Errors
#########################################

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name        = "${var.project_name}-alb-5xx"
  alarm_description = "Application Load Balancer is returning HTTP 5XX responses."

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5xx_Count"

  statistic = "Sum"

  period              = 300
  evaluation_periods  = 1
  threshold           = 5
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    LoadBalancer = var.load_balancer_arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = var.tags
}

#########################################
# Unhealthy Targets
#########################################

resource "aws_cloudwatch_metric_alarm" "unhealthy_targets" {
  alarm_name        = "${var.project_name}-unhealthy-targets"
  alarm_description = "One or more ALB targets are unhealthy."

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnhealthyHostCount"

  statistic = "Average"

  period              = 60
  evaluation_periods  = 2
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    loadBalancer = var.load_balancer_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = var.tags
}
