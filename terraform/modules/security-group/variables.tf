variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
