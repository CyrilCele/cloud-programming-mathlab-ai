output "log_group_name" {
  description = "CloudWatch Log Group name."

  value = aws_cloudwatch_log_group.application.name
}

output "log_group_arn" {
  description = "CloudWatch Log Group ARN."

  value = aws_cloudwatch_log_group.application.arn
}

output "sns_topic_arn" {
  description = "ARN of the CloudWatch SNS topic."

  value = aws_sns_topic.alerts.arn
}
