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

variable "cloudfront_origin_prefix_list_id" {
  description = "AWS-managed prefix list ID for CloudFront origin-facing infrastructure."
  type        = string

  validation {
    condition     = length(trimspace(var.cloudfront_origin_prefix_list_id)) > 0
    error_message = "cloudfront_origin_prefix_list_id cannot be empty."
  }
}
