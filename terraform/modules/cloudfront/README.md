# CloudFront Module

## Overview

The CloudFront module provisions an Amazon CloudFront distribution that serves as the global entry point for the MathLab AI Infrastructure.

CloudFront improves application performance by caching content at AWS edge locations around the world, reducing latency for users regardless of their geographic location.

The distribution uses the Application Load Balancer as its primary origin and Amazon S3 as the origin for static assets. Origin Access Control (OAC) is implemented to ensure that the S3 bucket remains private and can only be accessed through CloudFront.

---

# Features

- Creates an Amazon CloudFront Distribution
- Configures the Application Load Balancer as the primary origin
- Configures Amazon S3 as the static assets origin
- Implements Origin Access Control (OAC)
- Enables HTTPS delivery
- Redirects HTTP requests to HTTPS
- Supports custom domain names
- Supports ACM certificates
- Enables edge caching
- Applies consistent resource tagging

---

# Resources Created

| Resource                | Purpose                         |
| ----------------------- | ------------------------------- |
| CloudFront Distribution | Global content delivery network |
| Origin Access Control   | Secure access to Amazon S3      |

---

# Architecture

```
                User
                  │
                  ▼
        CloudFront Edge Location
                  │
        ┌─────────┴─────────┐
        ▼                   ▼
Application Load Balancer   Amazon S3
        │                   │
        ▼                   │
Auto Scaling Group          │
        │                   │
        ▼                   │
 EC2 Instances              │
```

CloudFront intelligently routes requests to the appropriate origin depending on the requested resource.

---

# Origins

## Application Load Balancer

Purpose:

- Dynamic application content

Origin Type:

- Custom Origin

Protocol:

- HTTP

Typical requests include:

- HTML pages
- API requests
- Dynamic application responses

---

## Amazon S3

Purpose:

- Static assets

Examples:

- Images
- CSS
- JavaScript
- Fonts
- Documents

Access to the bucket is restricted through Origin Access Control.

---

# Cache Behaviours

## Default Cache Behaviour

| Property               | Value                     |
| ---------------------- | ------------------------- |
| Target Origin          | Application Load Balancer |
| Viewer Protocol Policy | Redirect HTTP to HTTPS    |
| Allowed Methods        | GET, HEAD                 |
| Cached Methods         | GET, HEAD                 |
| Compression            | Enabled                   |

This behaviour serves all dynamic application requests.

---

## Assets Cache Behaviour

Path Pattern:

```
/assets/*
```

| Property               | Value                  |
| ---------------------- | ---------------------- |
| Target Origin          | Amazon S3              |
| Viewer Protocol Policy | Redirect HTTP to HTTPS |
| Compression            | Enabled                |
| Default TTL            | 86,400 seconds         |
| Maximum TTL            | 31,536,000 seconds     |

This configuration significantly reduces requests reaching the origin infrastructure.

---

# Origin Access Control

The module uses Amazon CloudFront Origin Access Control (OAC).

Benefits include:

- Private Amazon S3 bucket
- Signed origin requests
- Improved security
- AWS recommended architecture
- Replaces legacy Origin Access Identity (OAI)

End users cannot access the S3 bucket directly.

---

# HTTPS

CloudFront supports secure communication using an AWS Certificate Manager (ACM) certificate.

Features include:

- HTTPS encryption
- TLS 1.2 minimum
- Custom domain support
- SNI
- Automatic certificate management

All HTTP requests are redirected to HTTPS.

---

# Inputs

| Name                               | Description                            | Type        | Required |
| ---------------------------------- | -------------------------------------- | ----------- | -------- |
| project_name                       | Project name used for naming resources | string      | Yes      |
| alb_dns_name                       | Application Load Balancer DNS name     | string      | Yes      |
| assets_bucket_regional_domain_name | S3 bucket regional domain name         | string      | Yes      |
| domain_name                        | Custom domain name                     | string      | Yes      |
| certificate_arn                    | ACM certificate ARN                    | string      | Yes      |
| price_class                        | CloudFront Price Class                 | string      | No       |
| tags                               | Common resource tags                   | map(string) | Yes      |

---

# Outputs

| Output                   | Description                    |
| ------------------------ | ------------------------------ |
| origin_access_control_id | Origin Access Control ID       |
| distribution_id          | CloudFront Distribution ID     |
| distribution_arn         | CloudFront Distribution ARN    |
| distribution_domain_name | CloudFront Distribution domain |
| hosted_zone_id           | CloudFront Hosted Zone ID      |

---

# Dependencies

This module depends on:

- Application Load Balancer Module
- Amazon S3 Module
- ACM Module

Required inputs:

- ALB DNS Name
- S3 Bucket Regional Domain Name
- ACM Certificate ARN

This module is consumed by:

- Route 53 Records Module

---

# Example Usage

```hcl
module "cloudfront" {
  source = "../../modules/cloudfront"

  project_name = var.project_name

  alb_dns_name = module.alb.alb_dns_name

  assets_bucket_regional_domain_name = module.s3.bucket_regional_domain_name

  domain_name    = var.domain_name
  certificate_arn = module.acm.certificate_arn

  tags = local.common_tags
}
```

---

# Security

The CloudFront distribution follows AWS security best practices by:

- Enforcing HTTPS
- Redirecting HTTP requests
- Using TLS 1.2
- Restricting S3 access through Origin Access Control
- Preventing direct public access to the S3 bucket
- Supporting AWS Certificate Manager
- Encrypting traffic between clients and CloudFront

---

# Performance

CloudFront improves application performance through:

- Global edge locations
- Content caching
- Automatic compression
- Reduced origin load
- Lower network latency
- High availability
- Automatic request routing

These features satisfy the project requirement for global low-latency content delivery.

---

# Maintenance

When updating this module:

- Verify origin configuration.
- Review cache behaviours.
- Validate ACM certificate settings.
- Confirm Origin Access Control configuration.
- Execute `terraform validate`.
- Review the Terraform execution plan before deployment.

---

# Future Enhancements

Potential enhancements include:

- AWS WAF integration
- AWS Shield Advanced
- Custom error pages
- Lambda@Edge
- CloudFront Functions
- Response Headers Policies
- Real-Time Logs
- Origin Failover
- Geographic restrictions

These features can further improve security, resilience, and performance for enterprise deployments.

---

# Conclusion

The CloudFront module provides secure, high-performance content delivery for the MathLab AI Infrastructure. By integrating with the Application Load Balancer and Amazon S3, enforcing HTTPS, and leveraging AWS edge locations worldwide, it delivers a scalable, low-latency, and production-ready content delivery solution that meets the project's global availability requirements.
