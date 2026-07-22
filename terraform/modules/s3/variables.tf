variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "aws_region" {
  description = "AWS region containing the assets bucket."
  type        = string
}

variable "access_logs_bucket_id" {
  description = "ID of the central S3 bucket receiving assets-bucket server access logs."
  type        = string

  validation {
    condition     = length(trimspace(var.access_logs_bucket_id)) > 0
    error_message = "access_logs_bucket_id cannot be empty."
  }
}

variable "access_logs_prefix" {
  description = "Object-key prefix for assets-bucket server access logs."
  type        = string
  default     = "s3-assets/"
}
