output "autoscaling_group_id" {
  description = "ID of the Auto-Scaling Group."

  value = aws_autoscaling_group.this.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto-Scaling Group."

  value = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto-Scaling Group."

  value = aws_autoscaling_group.this.arn
}

output "scale_out_policy_arn" {
  description = "ARN of the scale-out policy."

  value = aws_autoscaling_policy.scale_out.arn
}

output "scale_in_policy_arn" {
  description = "ARN of the scale-in policy."

  value = aws_autoscaling_policy.scale_in.arn
}
