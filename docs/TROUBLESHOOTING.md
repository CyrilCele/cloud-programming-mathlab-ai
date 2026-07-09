# Troubleshooting Guide

## Overview

This document provides troubleshooting procedures for common issues that may occur during the deployment and operation of the MathLab AI Infrastructure.

Each issue includes:

- Symptoms
- Possible causes
- Resolution steps
- Verification procedures

The objective is to minimise downtime and provide a consistent approach to diagnosing infrastructure problems.

---

# General Troubleshooting Process

Before making changes:

1. Identify the affected component.
2. Review Terraform outputs.
3. Check AWS service health.
4. Review CloudWatch metrics and logs.
5. Verify recent infrastructure changes.
6. Confirm IAM permissions.
7. Validate network connectivity.
8. Apply the least disruptive fix.
9. Verify that the issue has been resolved.

---

# Terraform Issues

## Terraform Validation Failed

### Symptoms

- `terraform validate` returns one or more errors.

### Possible Causes

- Invalid Terraform syntax.
- Missing variables.
- Incorrect resource references.
- Unsupported provider configuration.

### Resolution

Run:

```bash
terraform fmt -recursive

terraform validate
```

Correct the reported errors before continuing.

---

## Terraform Plan Fails

### Symptoms

```
terraform plan
```

returns one or more errors.

### Possible Causes

- Missing variables.
- Incorrect module outputs.
- Invalid resource dependencies.
- Authentication failure.

### Resolution

Verify:

- AWS credentials.
- Module inputs.
- Terraform variables.
- Resource references.

Re-run:

```bash
terraform plan
```

---

## Terraform Apply Fails

### Symptoms

Infrastructure deployment stops unexpectedly.

### Possible Causes

- AWS service limits.
- Existing resources.
- Invalid IAM permissions.
- Incorrect resource configuration.

### Resolution

Review the Terraform error message.

Correct the reported issue.

Run:

```bash
terraform apply
```

again.

---

# AWS Authentication Issues

## Invalid AWS Credentials

### Symptoms

```
AccessDenied
```

or

```
ExpiredToken
```

### Resolution

Verify credentials.

```bash
aws sts get-caller-identity
```

Reconfigure credentials if required.

```bash
aws configure
```

---

# Networking Issues

## Internet Connectivity Failure

### Symptoms

Website unavailable.

### Possible Causes

- Internet Gateway missing.
- Route Table misconfigured.
- NAT Gateway failure.
- Security Group rules.

### Resolution

Verify:

- Internet Gateway
- NAT Gateway
- Route Tables
- Subnet Associations
- Security Groups

---

## DNS Resolution Failure

### Symptoms

Domain cannot be resolved.

### Possible Causes

- Route 53 record missing.
- Incorrect Alias record.
- DNS propagation incomplete.
- Incorrect Hosted Zone.

### Resolution

Verify:

- Hosted Zone
- Alias Records
- Name Servers
- CloudFront Domain Name

Wait for DNS propagation if necessary.

---

# EC2 Issues

## EC2 Instance Not Launching

### Symptoms

Auto Scaling reports failed launches.

### Possible Causes

- Invalid AMI.
- Incorrect Launch Template.
- IAM Instance Profile missing.
- Security Group issue.

### Resolution

Verify:

- AMI ID
- Launch Template
- Instance Profile
- Auto Scaling Activity History

---

## Bootstrap Script Failed

### Symptoms

Website unavailable after EC2 launch.

### Possible Causes

- S3 download failed.
- Incorrect bucket name.
- Website archive missing.
- Nginx installation failure.

### Resolution

Review:

```text
/var/log/cloud-init-output.log
```

Verify:

- website.zip exists.
- S3 permissions.
- Bootstrap script.

---

# Application Load Balancer Issues

## Unhealthy Targets

### Symptoms

Target Group reports unhealthy instances.

### Possible Causes

- Nginx not running.
- Incorrect Health Check path.
- Security Group restrictions.
- Application startup failure.

### Resolution

Verify:

- EC2 status
- Nginx service
- Target Group Health Checks
- Security Groups

---

# Auto Scaling Issues

## Instances Continuously Replaced

### Symptoms

Instances terminate shortly after launching.

### Possible Causes

- Failed Health Checks.
- Bootstrap errors.
- Incorrect Launch Template.

### Resolution

Review:

- Auto Scaling Activity
- EC2 System Logs
- CloudWatch Metrics
- Target Group Health

---

# Amazon S3 Issues

## Website Archive Missing

### Symptoms

Bootstrap cannot download website files.

### Resolution

Verify:

```bash
aws s3 ls s3://<bucket-name>
```

Upload the archive.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

---

## Access Denied

### Symptoms

403 Forbidden.

### Possible Causes

- Bucket Policy.
- IAM Policy.
- Origin Access Control.

### Resolution

Review:

- Bucket Policy
- IAM Permissions
- CloudFront OAC

---

# CloudFront Issues

## Distribution Still Deploying

### Symptoms

CloudFront status remains **In Progress**.

### Resolution

Wait until deployment status becomes:

```
Deployed
```

CloudFront deployments may require several minutes.

---

## Cached Content

### Symptoms

Old website content is displayed.

### Resolution

Invalidate the cache.

```bash
aws cloudfront create-invalidation \
--distribution-id <distribution-id> \
--paths "/*"
```

---

# Route 53 Issues

## Hosted Zone Created but Domain Does Not Resolve

### Possible Causes

- Incorrect Name Servers.
- DNS propagation.
- Alias record missing.

### Resolution

Verify:

- Hosted Zone
- Name Servers
- Alias Records
- CloudFront Domain

---

# ACM Issues

## Certificate Pending Validation

### Symptoms

Certificate remains in:

```
Pending Validation
```

### Resolution

Verify:

- DNS validation records.
- Route 53 Hosted Zone.
- Correct domain.

Allow time for DNS propagation.

---

# CloudWatch Issues

## Missing Metrics

### Possible Causes

- Monitoring disabled.
- Instance not running.

### Resolution

Verify:

- EC2 Monitoring
- CloudWatch configuration
- Instance Health

---

# Website Issues

## Website Displays 403

### Resolution

Verify:

- Bucket Policy
- CloudFront
- Website deployment
- File permissions

---

## Website Displays 404

### Resolution

Verify:

- Website extracted successfully.
- index.html exists.
- Bootstrap completed successfully.

---

## Website Loads Without CSS

### Resolution

Verify:

- Assets uploaded.
- CloudFront cache.
- Asset paths.
- Browser cache.

---

## Website Loads Slowly

### Resolution

Review:

- CloudFront
- ALB Metrics
- EC2 CPU
- Network Metrics

---

# Operational Commands

Terraform

```bash
terraform fmt -recursive

terraform validate

terraform plan

terraform apply
```

AWS Identity

```bash
aws sts get-caller-identity
```

Terraform Outputs

```bash
terraform output
```

S3 Upload

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

CloudFront Cache Invalidation

```bash
aws cloudfront create-invalidation \
--distribution-id <distribution-id> \
--paths "/*"
```

---

# Escalation Checklist

Before escalating an issue, confirm:

- Terraform validation succeeds.
- Terraform plan succeeds.
- AWS credentials are valid.
- EC2 instances are healthy.
- Target Group health checks pass.
- CloudFront is deployed.
- Route 53 records are correct.
- ACM certificate is issued.
- Website archive exists.
- CloudWatch metrics are available.

---

# Conclusion

This troubleshooting guide provides a structured approach for diagnosing and resolving common infrastructure issues within the MathLab AI Infrastructure. Following these procedures helps reduce downtime, maintain operational consistency, and support reliable cloud operations throughout the project's lifecycle.
