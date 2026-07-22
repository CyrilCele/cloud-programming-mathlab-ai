# S3 Module

## Overview

The S3 module provisions the Amazon Simple Storage Service (Amazon S3) bucket used by the MathLab AI Infrastructure.

The bucket stores the website deployment package (`website.zip`) and static application assets. It is designed with security, durability, and maintainability in mind by implementing encryption, versioning, lifecycle management, and public access restrictions.

The bucket is not publicly accessible. All requests for static assets are served through Amazon CloudFront using Origin Access Control (OAC).

---

# Features

- Creates an Amazon S3 bucket
- Enables bucket versioning
- Enables server-side encryption (SSE-S3)
- Blocks all public access
- Configures lifecycle management
- Supports CloudFront Origin Access Control (OAC)
- Applies consistent resource tagging

---

# Resources Created

| Resource                | Purpose                                             |
| ----------------------- | --------------------------------------------------- |
| S3 Bucket               | Stores deployment artifacts and static assets       |
| Bucket Versioning       | Protects against accidental deletion and overwrites |
| Server-Side Encryption  | Encrypts objects at rest                            |
| Public Access Block     | Prevents unintended public access                   |
| Lifecycle Configuration | Cleans up incomplete multipart uploads              |

---

# Architecture

```text
Developer
     │
     ▼
website.zip
     │
     ▼
Amazon S3
     │
     ▼
CloudFront Origin Access Control
     │
     ▼
CloudFront Distribution
     │
     ▼
End Users
```

The bucket is never accessed directly by end users.

---

# Security Features

The module implements multiple AWS security best practices.

## Block Public Access

All four S3 Block Public Access settings are enabled:

- Block Public ACLs
- Ignore Public ACLs
- Block Public Bucket Policies
- Restrict Public Buckets

These settings prevent accidental exposure of bucket contents.

---

## Server-Side Encryption

Server-side encryption is enabled using:

```text
AES-256 (SSE-S3)
```

All uploaded objects are encrypted automatically.

---

## Versioning

Versioning is enabled to protect against:

- Accidental deletion
- Accidental overwrite
- Data loss

Previous versions of objects can be restored when required.

---

## Lifecycle Configuration

The lifecycle policy automatically aborts incomplete multipart uploads after seven days.

This helps reduce unnecessary storage costs and keeps the bucket clean.

---

# Inputs

| Name        | Description                    | Type        | Required |
| ----------- | ------------------------------ | ----------- | -------- |
| bucket_name | Globally unique S3 bucket name | string      | Yes      |
| tags        | Common resource tags           | map(string) | Yes      |

---

# Outputs

| Output                      | Description                             |
| --------------------------- | --------------------------------------- |
| bucket_name                 | S3 bucket name                          |
| bucket_id                   | S3 bucket ID                            |
| bucket_arn                  | S3 bucket ARN                           |
| bucket_regional_domain_name | Regional domain name used by CloudFront |

---

# Dependencies

This module has no infrastructure dependencies.

It provides outputs consumed by:

- IAM Module
- CloudFront Module
- Bootstrap Script
- Production Environment

---

# Example Usage

````hcl
module "s3" {
  source = "../../modules/s3"

  bucket_name = var.assets_bucket_name

  tags = local.common_tags
}
```text

---

# Operational Notes

The deployment workflow is:

1. Package the website.

```bash
zip -r website.zip website/
````

2. Upload the archive.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

3. Launch Template downloads the archive during instance provisioning.

4. The bootstrap script extracts the website into:

```text
/var/www/html
```

5. Nginx serves the website.

---

# Best Practices

The module follows AWS best practices by:

- Blocking all public access
- Encrypting all objects
- Enabling versioning
- Using lifecycle management
- Serving content through CloudFront
- Managing infrastructure using Terraform
- Applying consistent resource tags

---

# Maintenance

When updating this module:

- Review bucket policies.
- Validate encryption settings.
- Confirm versioning remains enabled.
- Verify lifecycle rules.
- Ensure CloudFront integration continues to function.
- Review Terraform execution plans before deployment.

---

# Future Enhancements

Potential improvements include:

- SSE-KMS encryption
- Cross-Region Replication
- Intelligent Tiering
- Access Logging
- Object Lock
- Event Notifications
- Inventory Reports
- Storage Lens

These enhancements were excluded to keep the project aligned with the university specification while maintaining a production-oriented design.

---

# Conclusion

The S3 module provides secure and durable object storage for the MathLab AI Infrastructure. By combining encryption, versioning, lifecycle management, and CloudFront integration, it delivers a secure, scalable, and highly available storage solution suitable for modern cloud applications.
