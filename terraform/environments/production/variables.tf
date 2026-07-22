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

variable "vpc_cidr" {
  description = "CIDR block assigned to the VPC."
  type        = string
}

variable "public_subnet_cidr_a" {
  description = "CIDR block for Public Subnet A."
  type        = string
}

variable "public_subnet_cidr_b" {
  description = "CIDR block for Public Subnet B."
  type        = string
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for Private Subnet A."
  type        = string
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for Private Subnet B."
  type        = string
}

variable "assets_bucket_name" {
  description = "Globally unique S3 bucket name."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications."
  type        = string
}

#########################################
# Domain
#########################################

variable "domain_name" {
  description = "Custom domain."

  type = string
}


variable "resource_prefix" {
  description = "Short prefix used for AWS resources with strict name limits."
  type        = string
}

#########################################
# Observability
#########################################

variable "log_retention_days" {
  description = "Number of days CloudWatch application logs are retained."
  type        = number
  default     = 365

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_days)
    error_message = "log_retention_days must be a retention period supported by CloudWatch Logs."
  }
}

variable "access_log_retention_days" {
  description = "Number of days ALB, CloudFront, and VPC Flow Logs are retained."
  type        = number
  default     = 365

  validation {
    condition     = var.access_log_retention_days >= 1
    error_message = "access_log_retention_days must be at least one day."
  }
}
