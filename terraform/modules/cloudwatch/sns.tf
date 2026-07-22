#########################################
# SNS Topic
#########################################

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"

  kms_master_key_id = aws_kms_key.observability.arn

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-alerts"
    }
  )
}

#########################################
# Email Subscription
#########################################

resource "aws_sns_topic_subscription" "email" {
  count = var.alert_email == "" ? 0 : 1

  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
