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

output "scale_out_policy" {
  description = "Scale-out policy ARN."
  value       = aws_autoscaling_policy.scale_out.arn
}

output "scale_in_policy" {
  description = "Scale-in policy ARN."
  value       = aws_autoscaling_policy.scale_in.arn
}

output "high_cpu_alarm" {
  description = "High CPU Alarm ARN."
  value       = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "low_cpu_alarm" {
  description = "Low CPU Alarm ARN."
  value       = aws_cloudwatch_metric_alarm.low_cpu.alarm_name
}

output "s3_bucket_name" {
  description = "Amazon S3 bucket"
  value       = aws_s3_bucket.website.bucket
}

output "s3_bucket_arn" {
  description = "Amazon S3 bucket ARN"
  value       = aws_s3_bucket.website.arn
}
