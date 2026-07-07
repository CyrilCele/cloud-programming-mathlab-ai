variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "assets_bucket_arn" {
  description = "ARN of the S3 assest bucket."
  type        = string
}
