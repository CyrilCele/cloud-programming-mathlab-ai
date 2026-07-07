variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  type        = string
}

variable "assets_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 assets bucket."
  type        = string
}

variable "price_class" {
  description = "CloudFront price class."
  type        = string

  default = "PriceClass_100"
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
