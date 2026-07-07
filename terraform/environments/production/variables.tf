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
