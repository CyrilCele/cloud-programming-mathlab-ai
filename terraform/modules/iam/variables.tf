variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "assets_bucket_arn" {
  description = "ARN of the S3 assets bucket."
  type        = string

  validation {
    condition     = can(regex("^arn:[^:]+:s3:::[^/]+$", var.assets_bucket_arn))
    error_message = "assets_bucket_arn must be a valid S3 bucket ARN without an object suffix."
  }
}

variable "cloudwatch_metric_namespace" {
  description = "CloudWatch custom metric namespace that EC2 instances may publish to."
  type        = string

  validation {
    condition = (
      length(trimspace(var.cloudwatch_metric_namespace)) > 0 &&
      !startswith(var.cloudwatch_metric_namespace, "AWS/")
    )

    error_message = "cloudwatch_metric_namespace must not be empty or start with the reserved AWS/ prefix."
  }
}
