variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "ami_id" {
  description = "Ubuntu Server AMI ID."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "instance_profile_name" {
  description = "IAM Instance Profile name."
  type        = string
}

variable "security_group_id" {
  description = "EC2 Security Group ID."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "user_data" {
  description = "Base64-encoded EC2 user data."
  type        = string
}
