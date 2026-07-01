output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.web.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.web.latest_version
}

output "load_balancer_dns" {
  description = "Load Balancer DNS Name"
  value       = aws_lb.web.dns_name
}

output "load_balancer_arn" {
  description = "Load Balancer ARN"
  value       = aws_lb.web.arn
}

output "auto_scaling_group_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.web.name
}
