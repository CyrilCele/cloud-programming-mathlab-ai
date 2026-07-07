#########################################
# CloudWatch Log Group
#########################################

resource "aws_cloudwatch_log_group" "application" {
  name = "/aws/ec2/${var.project_name}"

  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-logs"
    }
  )
}
