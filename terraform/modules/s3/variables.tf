variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
