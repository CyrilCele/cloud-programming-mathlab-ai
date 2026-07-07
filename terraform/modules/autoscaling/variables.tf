variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID."
  type        = string
}

variable "launch_template_latest_version" {
  description = "Latest Launch Template version."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs."
  type        = list(string)
}

variable "target_group_arn" {
  description = "Application Load Balancer Target Group ARN."
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum Auto Scaling Group size."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum Auto Scaling Group size."
  type        = number
  default     = 4
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
