# Security Policy

## Overview

The MathLab AI Infrastructure project follows security best practices for Infrastructure as Code (IaC), AWS resource provisioning, and repository management.

This document explains how to report security vulnerabilities and outlines the security principles applied throughout the project.

---

# Supported Versions

The latest release receives security updates.

| Version | Supported |
| ------- | --------- |
| 1.x.x   | ✅        |
| < 1.0.0 | ❌        |

---

# Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly.

When submitting a report, include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested remediation (if known)

Please do not publicly disclose security issues until they have been reviewed.

---

# Security Principles

The project follows the following security principles.

## Least Privilege

AWS Identity and Access Management (IAM) permissions follow the principle of least privilege.

Permissions are granted only when required.

---

## Infrastructure as Code

All AWS resources are provisioned using Terraform.

Manual configuration changes are discouraged.

---

## Encryption

The project uses encryption where supported.

Examples include:

- Amazon S3 server-side encryption
- HTTPS through Amazon CloudFront
- AWS Certificate Manager (ACM)

---

## Network Security

The infrastructure is deployed inside an Amazon Virtual Private Cloud (VPC).

Security Groups restrict inbound and outbound traffic.

Only required ports are exposed.

---

## Public Access Protection

Amazon S3 Block Public Access is enabled.

Static assets are served through Amazon CloudFront using Origin Access Control (OAC).

Direct public access to the S3 bucket is prohibited.

---

## Transport Security

HTTPS is enforced for all viewer requests through CloudFront.

Modern TLS protocols are used.

HTTP requests are redirected to HTTPS.

---

## Logging and Monitoring

Monitoring is implemented using Amazon CloudWatch.

Infrastructure health is monitored through:

- EC2 metrics
- Auto Scaling metrics
- Application Load Balancer metrics

---

## Secrets Management

Sensitive information should never be committed to the repository.

Examples include:

- AWS Access Keys
- Secret Access Keys
- Private certificates
- PEM files
- Terraform state files containing secrets

Secrets should instead be managed using:

- AWS Secrets Manager
- AWS Systems Manager Parameter Store
- GitHub Secrets

---

## Repository Security

The repository includes automated validation for:

- Terraform formatting
- Terraform validation
- Repository quality
- Shell script quality
- Markdown validation

GitHub Actions perform continuous integration checks on every change.

---

## Dependencies

Project dependencies should be kept up to date.

Security scanning tools such as the following are recommended:

- tfsec
- Checkov
- ShellCheck
- markdownlint

---

## Best Practices

Contributors should:

- Validate Terraform before committing.
- Run all repository tests.
- Avoid committing generated files.
- Review IAM permissions carefully.
- Follow secure coding practices.

---

# Additional Documentation

Further security implementation details are available in:

- `docs/SECURITY.md`
- `docs/OPERATIONS.md`
- `docs/TESTING.md`
- `docs/TROUBLESHOOTING.md`

---

# Contact

For questions regarding repository security, please open a private security report through the project's issue reporting process.
