# Testing Guide

This document defines the testing strategy used to validate the AWS Infrastructure throughout development and before production deployment.

The objective of testing is to ensure that the infrastructure is reliable, secure, reproducible, and production-ready.

---

# Testing Objectives

The testing process aims to verify that:

- Infrastructure provisions successfully.
- Terraform configuration is valid.
- AWS resources are created correctly.
- Networking functions as expected.
- Security controls are correctly implemented.
- Monitoring is operational.
- The website is accessible.
- Infrastructure changes do not introduce regressions.

---

# Testing Strategy

Testing is performed throughout the project rather than only at the end.

Each milestone concludes with validation to ensure that the repository remains in a deployable state.

Testing includes:

- Terraform validation
- Infrastructure verification
- Functional testing
- Security verification
- Documentation review

---

# Terraform Validation

Terraform configurations must pass the following commands before deployment.

## Format Check

```bash
terraform fmt -recursive
```

Purpose:

- Ensure consistent formatting.
- Follow HashiCorp formatting standards.

Expected Result:

- No formatting errors.

---

## Configuration Validation

```bash
terraform validate
```

Purpose:

- Verify Terraform syntax.
- Detect configuration errors.
- Validate module references.

Expected Result:

```text
Success! The configuration is valid.
```

---

## Execution Plan

```bash
terraform plan
```

Purpose:

- Review infrastructure changes.
- Verify planned resource creation.
- Detect unintended modifications before deployment.

Expected Result:

- Terraform generates a valid execution plan without errors.

---

# Infrastructure Testing

Infrastructure testing verifies that AWS resources function correctly after deployment.

Resources to verify include:

- VPC
- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- IAM Roles
- EC2 Instances
- Launch Template
- Auto Scaling Group
- Application Load Balancer
- CloudFront Distribution
- Amazon S3
- Route 53
- CloudWatch

Verification procedures will be documented as each component is implemented.

---

# Website Testing

After deployment, verify that:

- The website loads successfully.
- HTML pages are accessible.
- CSS files load correctly.
- JavaScript executes correctly.
- Images are displayed.
- Static assets are served successfully.

The website source code is not modified as part of this project.

---

# Network Testing

Network testing verifies:

- Internet connectivity.
- Public subnet accessibility.
- Security Group configuration.
- Load Balancer connectivity.
- Route 53 resolution.
- CloudFront routing.

Additional network validation procedures will be added during the Networking milestone.

---

# Security Testing

Security validation includes:

- IAM least privilege verification.
- Security Group review.
- Public exposure review.
- Encryption verification.
- Credential management review.
- Terraform state protection.

Detailed security testing procedures will be added as infrastructure components are implemented.

---

# Monitoring Verification

Monitoring tests verify:

- CloudWatch metrics.
- CloudWatch alarms.
- CloudWatch dashboards.
- EC2 instance health.
- Auto Scaling metrics.

These tests will be documented during the CloudWatch milestone.

---

# Deployment Verification Checklist

After infrastructure deployment, verify the following.

| Component        | Verification                         |
| ---------------- | ------------------------------------ |
| Terraform        | Configuration validates successfully |
| VPC              | Created successfully                 |
| Subnets          | Created successfully                 |
| Internet Gateway | Attached to VPC                      |
| Route Tables     | Associated correctly                 |
| Security Groups  | Rules configured correctly           |
| IAM              | Roles and policies attached          |
| EC2              | Instances running                    |
| Nginx            | Service running                      |
| Website          | Accessible                           |
| ALB              | Healthy targets                      |
| Auto Scaling     | Desired capacity achieved            |
| CloudFront       | Distribution deployed                |
| Route 53         | DNS resolution successful            |
| CloudWatch       | Metrics and alarms available         |

---

# Documentation Verification

Documentation should be reviewed after every milestone to ensure that it accurately reflects the current infrastructure.

Review includes:

- README.md
- ARCHITECTURE.md
- DEPLOYMENT.md
- SECURITY.md
- TESTING.md
- TROUBLESHOOTING.md
- DECISIONS.md
- COST_ESTIMATION.md
- OPERATIONS.md

---

# Quality Gate

Before completing a milestone, verify that:

- Terraform formatting passes.
- Terraform validation passes.
- Infrastructure is deployable.
- Documentation is updated.
- Repository structure is maintained.
- Security has been reviewed.
- AWS best practices are followed.

No milestone should be considered complete until all quality checks pass.

---

# Future Updates

This document will be expanded throughout the project to include:

- Networking validation procedures
- IAM validation procedures
- CloudFront verification
- Load Balancer testing
- Auto Scaling testing
- Route 53 verification
- CloudWatch testing
- Production validation checklist
- Final infrastructure acceptance testing

---

# Current Status

| Testing Area           | Status         |
| ---------------------- | -------------- |
| Testing Strategy       | ✅ Defined     |
| Terraform Validation   | 🟡 In Progress |
| Infrastructure Testing | ⏳ Pending     |
| Network Testing        | ⏳ Pending     |
| Security Testing       | ⏳ Pending     |
| Monitoring Testing     | ⏳ Pending     |
| Production Validation  | ⏳ Pending     |
