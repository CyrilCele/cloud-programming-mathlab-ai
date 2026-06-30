output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.web.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.web.latest_version
}
