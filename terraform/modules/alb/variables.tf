variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "security_group_id" {
  description = "Application Load Balancer Security Group ID."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection on the ALB."
  type        = bool
  default     = false # I kept it false for marking purposes
}

variable "access_logs_bucket_name" {
  description = "Name of the S3 bucket receiving ALB access logs."
  type        = string
}

variable "access_logs_bucket_prefix" {
  description = "S3 object prefix used for ALB access logs."
  type        = string
  default     = "alb"

  validation {
    condition     = !strcontains(var.access_logs_bucket_prefix, "AWSLogs")
    error_message = "The ALB access-log prefix must not contain AWSLogs."
  }
}
