variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "mathlab-ai"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1" {
  type        = string
  description = "Public subnet 1 CIDR block"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2" {
  type        = string
  description = "Public subnet 2 CIDR block"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1" {
  type        = string
  description = "Private subnet 1 CIDR block"
  default     = "10.0.11.0/24"
}

variable "private_subnet_2" {
  type        = string
  description = "Private subnet 2 CIDR block"
  default     = "10.0.12.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Existing AWS EC2 Key Pair."
  type        = string
  default     = null
}

variable "environment" {
  description = "Deployment environment (e.g., Development, Staging, Production)"
  type        = string
  default     = "Development"
}
