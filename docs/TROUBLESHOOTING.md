# Troubleshooting Guide

This document provides guidance for identifying, diagnosing, and resolving common issues encountered during the deployment, operation, and maintenance of the AWS Infrastructure.

The procedures documented here are intended to reduce downtime, improve operational efficiency, and support consistent issue resolution.

---

# Troubleshooting Process

When an issue occurs, follow this sequence:

1. Identify the affected component.
2. Review the error message.
3. Verify the Terraform configuration.
4. Check AWS resource status.
5. Review CloudWatch metrics and logs (where applicable).
6. Apply the appropriate resolution.
7. Revalidate the infrastructure.

---

# Terraform Issues

## Terraform Initialization Fails

### Symptoms

- `terraform init` returns an error.
- Providers fail to download.
- Backend initialization fails.

### Possible Causes

- Internet connectivity issues.
- Incorrect provider configuration.
- Backend configuration errors.
- Unsupported Terraform version.

### Resolution

- Verify the internet connection.
- Confirm the Terraform version.
- Verify provider configuration.
- Review backend configuration.
- Re-run:

```bash
terraform init
```

---

## Terraform Validation Fails

### Symptoms

```text
Error: Invalid configuration
```

### Possible Causes

- Syntax errors.
- Invalid resource references.
- Missing variables.
- Module configuration errors.

### Resolution

Run:

```bash
terraform fmt -recursive

terraform validate
```

Correct all reported issues before continuing.

---

## Terraform Plan Fails

### Possible Causes

- Invalid variables.
- Authentication failure.
- Missing AWS permissions.
- Invalid resource configuration.

### Resolution

Verify:

- AWS credentials.
- Required variables.
- IAM permissions.
- Terraform configuration.

Re-run:

```bash
terraform plan
```

---

## Terraform Apply Fails

### Possible Causes

- AWS service quota exceeded.
- Invalid AWS configuration.
- Missing IAM permissions.
- Dependency errors.
- Resource conflicts.

### Resolution

Review the Terraform output.

Resolve the reported issue.

Re-run:

```bash
terraform apply
```

---

# AWS Authentication Issues

## AWS CLI Authentication Failure

### Symptoms

```text
Unable to locate credentials
```

### Resolution

Verify the AWS CLI configuration.

```bash
aws configure
```

Confirm the active identity.

```bash
aws sts get-caller-identity
```

---

# EC2 Issues

## EC2 Instance Not Running

### Possible Causes

- Launch Template configuration.
- Auto Scaling issues.
- IAM permissions.
- User Data execution failure.

### Resolution

Verify:

- EC2 instance status.
- Auto Scaling Group status.
- Launch Template configuration.
- System logs.

---

## Website Not Loading

### Possible Causes

- Nginx not running.
- Website files missing.
- Security Group configuration.
- Load Balancer configuration.

### Resolution

Verify:

- Nginx service.
- Website deployment.
- Security Group rules.
- Target Group health.

---

# Load Balancer Issues

## Unhealthy Targets

### Possible Causes

- Nginx unavailable.
- Incorrect health check configuration.
- Security Group restrictions.
- Incorrect target registration.

### Resolution

Verify:

- EC2 instance health.
- Nginx status.
- Target Group health checks.
- Security Groups.

---

# Auto Scaling Issues

## Instances Not Launching

### Possible Causes

- Launch Template errors.
- IAM permissions.
- Insufficient capacity.
- Invalid subnet configuration.

### Resolution

Review:

- Auto Scaling Activity History.
- Launch Template.
- EC2 console.
- CloudWatch events.

---

# CloudFront Issues

## Distribution Not Serving Content

### Possible Causes

- Origin configuration.
- Cache configuration.
- Origin Access Control.
- Deployment still in progress.

### Resolution

Verify:

- Distribution status.
- Origin settings.
- Cache behavior.
- Distribution deployment status.

---

# Route 53 Issues

## Domain Does Not Resolve

### Possible Causes

- Incorrect hosted zone.
- Missing DNS records.
- DNS propagation.

### Resolution

Verify:

- Hosted Zone.
- Alias records.
- Domain registration.
- DNS propagation.

---

# CloudWatch Issues

## Metrics Missing

### Possible Causes

- Metrics not enabled.
- Resource not running.
- Incorrect dashboard configuration.

### Resolution

Verify:

- Resource status.
- CloudWatch dashboard.
- Metric namespace.
- Alarm configuration.

---

# Security Issues

Review the following:

- IAM Roles
- IAM Policies
- Security Groups
- Encryption
- Public access
- S3 Bucket Policies
- CloudFront configuration

Refer to `SECURITY.md` for detailed security guidance.

---

# Diagnostic Commands

Terraform

```bash
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform destroy
```

AWS CLI

```bash
aws configure

aws sts get-caller-identity
```

Git

```bash
git status
```

---

# Escalation Checklist

Before escalating an issue, verify:

- Terraform configuration.
- AWS credentials.
- Required IAM permissions.
- Variable configuration.
- Infrastructure status.
- CloudWatch metrics.
- Relevant documentation.

---

# Future Updates

This document will be expanded throughout the project.

Future milestones will include troubleshooting guidance for:

- Networking
- IAM
- S3
- CloudFront
- Launch Template
- Application Load Balancer
- Auto Scaling
- CloudWatch
- Route 53
- Production Hardening

---

# Current Status

| Component             | Status         |
| --------------------- | -------------- |
| Terraform             | 🟡 In Progress |
| AWS Authentication    | 🟡 In Progress |
| EC2                   | ⏳ Pending     |
| Load Balancer         | ⏳ Pending     |
| Auto Scaling          | ⏳ Pending     |
| CloudFront            | ⏳ Pending     |
| Route 53              | ⏳ Pending     |
| CloudWatch            | ⏳ Pending     |
| Production Operations | ⏳ Pending     |
