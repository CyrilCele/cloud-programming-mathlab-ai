#########################################
# Managed Response Headers Policy
#########################################

data "aws_cloudfront_response_headers_policy" "security_headers" {
  name = "Managed-SecurityHeadersPolicy"
}

#########################################
# Origin Access Control
#########################################

resource "aws_cloudfront_origin_access_control" "assets" {
  name                              = "${var.project_name}-oac"
  description                       = "Origin Access Control for S3."
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

#########################################
# CloudFront Distribution
#########################################

#checkov:skip=CKV_AWS_310:The application currently has one authoritative dynamic origin; failover requires an independently deployable secondary application origin and replicated state.
#checkov:skip=CKV_AWS_374:The application has no approved geographic allowlist or denylist; imposing one would block legitimate users without a business or regulatory requirement.
#checkov:skip=CKV2_AWS_47:The associated WAF includes AWSManagedRulesKnownBadInputsRuleSet, which provides managed protection for known malicious payloads including Log4j-style exploit input; this graph check does not resolve the module association correctly.
resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.project_name} CloudFront Distribution"
  default_root_object = "index.html"
  web_acl_id          = aws_wafv2_web_acl.cloudfront.arn

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  origin {
    domain_name              = var.assets_bucket_regional_domain_name
    origin_id                = "assets-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.assets.id
  }

  default_cache_behavior {
    target_origin_id           = "alb-origin"
    viewer_protocol_policy     = "redirect-to-https"
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers.id

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern               = "/assets/*"
    target_origin_id           = "assets-origin"
    viewer_protocol_policy     = "redirect-to-https"
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers.id

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  logging_config {
    bucket          = var.access_logs_bucket_domain_name
    include_cookies = false
    prefix          = var.access_logs_prefix
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = [
    var.domain_name
  ]

  price_class = var.price_class

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cloudfront"
    }
  )
}
