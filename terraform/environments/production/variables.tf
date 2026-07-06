variable "aws_region" {
  description = "AWS region where infrastructure will be provisioned"
  type        = string
}

variable "project_name" {
  description = "Name of the project used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile used for authentication."
  type        = string
  default     = "default"
}
