variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch Logs."
  type        = number
  default     = 365
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "autoscaling_group_name" {
  description = "Name of the Auto-Scaling Group."
  type        = string
}

variable "load_balancer_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer."
  type        = string
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the Target Group."
  type        = string
}

variable "alert_email" {
  description = "Email address that receives CloudWatch alarm notifications."
  type        = string

  default = ""
}

variable "aws_region" {
  description = "AWS region containing the CloudWatch and SNS resources."
  type        = string
}
