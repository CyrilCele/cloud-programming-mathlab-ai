output "origin_access_control_id" {
  description = "ID of the CloudFront Origin Access Control."

  value = aws_cloudfront_origin_access_control.assets.id
}

output "distribution_id" {
  description = "CloudFront distribution ID."

  value = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN."

  value = aws_cloudfront_distribution.this.arn
}

output "distribution_domain_name" {
  description = "CloudFront distribution domain name."

  value = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront hosted zone ID"

  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "web_acl_arn" {
  description = "ARN of the AWS WAF Web ACL attached to CloudFront."

  value = aws_wafv2_web_acl.cloudfront.arn
}
