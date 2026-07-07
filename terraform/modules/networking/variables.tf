variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the VPC."
  type        = string
}

variable "availability_zones" {
  description = "List of Availability Zones used by the VPC."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones are required for High Availability."
  }
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

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
