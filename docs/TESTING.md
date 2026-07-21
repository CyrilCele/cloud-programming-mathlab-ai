# Testing Guide

## Overview

This document describes the testing procedures used to verify the AWS Terraform Infrastructure project.

Testing ensures that the infrastructure is correctly provisioned, secure, and functioning as expected.

---

# Testing Workflow

The project includes multiple levels of testing:

- Terraform formatting
- Terraform validation
- Terraform planning
- Infrastructure deployment
- DNS validation
- SSL certificate validation
- Load Balancer health checks
- Website accessibility
- Infrastructure verification
- Security scanning

---

# Terraform Formatting

Ensure consistent formatting.

```bash
terraform fmt -recursive
```

---

# Terraform Validation

Validate the configuration.

```bash
terraform validate
```

---

# Terraform Plan

Review planned infrastructure changes.

```bash
terraform plan
```

---

# Infrastructure Verification

Run the automated verification script.

```bash
make verify
```

The script verifies:

- AWS authentication
- Terraform outputs
- S3 bucket access
- HTTPS availability
- Load Balancer accessibility
- Target Group health
- Website availability

---

# Manual AWS Verification

Verify the Application Load Balancer.

```bash
aws elbv2 describe-load-balancers
```

Verify target health.

```bash
aws elbv2 describe-target-health \
    --target-group-arn <target-group-arn>
```

Verify Auto Scaling.

```bash
aws autoscaling describe-auto-scaling-groups
```

Verify S3.

```bash
aws s3 ls s3://<bucket-name>
```

Verify Route 53.

```bash
aws route53 list-hosted-zones
```

---

# Website Testing

Verify that:

- The website loads successfully.
- HTTPS is enabled.
- Static assets load correctly.
- The website returns HTTP 200.

Example:

```bash
curl -I https://<your-domain>
```

---

# Expected Results

A successful deployment should produce:

- Successful Terraform validation
- Successful Terraform plan
- Healthy Load Balancer targets
- Valid ACM certificate
- Successful HTTPS connection
- Website accessible from the browser

---

# Quality Assurance

The project includes automated quality checks using:

- Terraform Validate
- Terraform Plan
- TFLint
- Checkov
- GitHub Actions

Run all quality checks.

```bash
make quality
```

---

# Testing Summary

The project combines automated and manual testing to ensure the infrastructure is reliable, secure, and ready for production deployment.
