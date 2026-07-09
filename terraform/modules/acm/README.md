# ACM Module

## Overview

The AWS Certificate Manager (ACM) module provisions and validates a public SSL/TLS certificate for the MathLab AI Infrastructure.

The certificate enables secure HTTPS communication between users and the CloudFront distribution. DNS validation is performed automatically using Amazon Route 53, allowing certificate issuance and renewal without manual intervention.

The certificate is created in the **US East (N. Virginia)** Region (`us-east-1`), as required by Amazon CloudFront.

---

# Features

- Creates an AWS Certificate Manager (ACM) certificate
- Performs automatic DNS validation
- Integrates with Amazon Route 53
- Supports automatic certificate renewal
- Enables HTTPS for CloudFront
- Eliminates manual certificate management
- Applies consistent resource tagging

---

# Resources Created

| Resource                    | Purpose                         |
| --------------------------- | ------------------------------- |
| ACM Certificate             | Public SSL/TLS certificate      |
| Route 53 Validation Records | DNS validation records          |
| ACM Certificate Validation  | Validates certificate ownership |

---

# Architecture

```
                 User
                   │
             HTTPS Request
                   │
                   ▼
          CloudFront Distribution
                   │
                   ▼
          ACM Certificate (TLS)
                   │
                   ▼
         Route 53 DNS Validation
```

The ACM certificate secures all HTTPS traffic delivered through CloudFront.

---

# Certificate Validation

The module uses **DNS validation**, the AWS-recommended validation method.

Validation workflow:

```
Request Certificate
        │
        ▼
Generate DNS Validation Records
        │
        ▼
Create Route 53 Records
        │
        ▼
AWS Verifies Ownership
        │
        ▼
Certificate Issued
```

Once validated, ACM automatically renews the certificate before expiration.

---

# Supported Features

The certificate supports:

- HTTPS
- TLS encryption
- Automatic renewal
- CloudFront integration
- Custom domain names
- Subject Alternative Names (SANs)

---

# Inputs

| Name                      | Description             | Type         | Required |
| ------------------------- | ----------------------- | ------------ | -------- |
| domain_name               | Primary domain name     | string       | Yes      |
| subject_alternative_names | Additional domain names | list(string) | No       |
| hosted_zone_id            | Route 53 Hosted Zone ID | string       | Yes      |
| tags                      | Common resource tags    | map(string)  | Yes      |

---

# Outputs

| Output                  | Description                   |
| ----------------------- | ----------------------------- |
| certificate_arn         | ACM Certificate ARN           |
| certificate_domain_name | Certificate domain            |
| validation_status       | Certificate validation status |

---

# Dependencies

This module depends on:

- Route 53 Hosted Zone Module

Required input:

- Hosted Zone ID

This module is consumed by:

- CloudFront Module

---

# Example Usage

```hcl
module "acm" {
  source = "../../modules/acm"

  domain_name = var.domain_name

  hosted_zone_id = module.route53_zone.hosted_zone_id

  tags = local.common_tags

  providers = {
    aws = aws.us-east-1
  }
}
```

---

# Regional Requirement

Amazon CloudFront requires ACM certificates to be created in:

```
us-east-1
```

Even if the rest of the infrastructure is deployed in another AWS Region, the certificate must exist in US East (N. Virginia).

This requirement is enforced by AWS.

---

# Security

The ACM module improves security by:

- Encrypting all client traffic
- Eliminating self-signed certificates
- Supporting automatic renewal
- Preventing expired certificates
- Integrating with AWS Identity and Access Management
- Removing manual certificate handling

---

# Automatic Renewal

After successful DNS validation:

- AWS monitors certificate validity.
- ACM renews the certificate automatically.
- Route 53 validation records remain in place.
- No operational intervention is required.

This eliminates one of the most common causes of HTTPS outages.

---

# Maintenance

When updating this module:

- Verify the domain name.
- Confirm Route 53 validation records exist.
- Ensure the certificate is issued in `us-east-1`.
- Review Terraform execution plans before deployment.
- Execute `terraform validate`.

---

# Future Enhancements

Potential improvements include:

- Wildcard certificates
- Multiple Subject Alternative Names (SANs)
- Cross-account certificate sharing
- Private Certificate Authority (Private CA)
- Certificate transparency monitoring
- Certificate lifecycle dashboards

These enhancements are valuable for enterprise-scale deployments but are outside the scope of this project.

---

# Troubleshooting

## Certificate remains in "Pending Validation"

Verify that:

- Route 53 validation records have been created.
- The hosted zone matches the requested domain.
- DNS propagation has completed.

---

## CloudFront cannot use the certificate

Ensure:

- The certificate is in **us-east-1**.
- The certificate status is **Issued**.
- The domain name matches the CloudFront alias.

---

# Conclusion

The ACM module provides secure certificate management for the MathLab AI Infrastructure. By automating certificate provisioning, DNS validation, and renewal, it enables secure HTTPS communication while reducing operational overhead and ensuring compliance with AWS best practices.
