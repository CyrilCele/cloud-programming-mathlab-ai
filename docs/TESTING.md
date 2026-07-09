# Testing Guide

## Overview

This document describes the testing strategy used to validate the MathLab AI Infrastructure.

The projects adopts a layered testing approach to verify infrastructure configuration, deployment correctness, operational readiness, and application availability.

Testing is performed before deployment, during deployment, and after deployment to ensure the infrastructure remains reliable, secure, and maintainable.

---

# Testing Objectives

The objectives of testing are to:

- Validate Terraform configuration.
- Detect syntax errors.
- Detect infrastructure configuration errors.
- Verify AWS resource provisioning.
- Validate network connectivity.
- Confirm website availability.
- Verify security controls.
- Validate infrastructure scalability.
- Ensure repeatable deployments.

---

# Testing Strategy

The project uses multiple levels of testing.

![Testing Strategy](../images/Testing%20Strategy.png)

---

# Test Environment

Infrastructure is deployed into the AWS Production environment defined within:

```
terraform/environments/production
```

Testing is performed using:

- Terraform CLI
- AWS CLI
- AWS Management Console
- Web Browser
- Amazon CloudWatch

---

# Static Validation

Terraform configuration must always be formulated before validation

```bash
terraform fmt -recursive
```

Expected result:

- All Terraform files are consistently formatted.

---

## Terraform Validation

Validate the configuration.

```bash
terraform validate
```

Expected output:

```
Success! The configuration is valid.
```

No earnings or errors should prevent deployment.

---

# Execution Plan Validation

Generate an execution plan.

```bash
terraform plan
```

Verify:

- Resources are created as expected.
- No unexpected resource deletions.
- Resource dependencies are correct.

---

# Deployment Testing

Deploy the infrastructure.

```bash
terraform apply
```

Expected result

- Deployment completes successfully.
- No failed resources.
- Outputs are generated.

---

# Infrastructure Verification

Verify the successful creation of:

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Security Groups
- IAM Role
- IAM Instance Profile
- Amazon S3 Bucket
- Launch Template
- Auto Scaling Group
- Application Load Balancer
- CloudFront Distribution
- Route 53 Hosted Zone
- Route 53 Records
- ACM Certificate
- CloudWatch Resources

Each resource should be present and in a healthy state.

---

# Networking Tests

Verify:

- Internet connectivity through the Application Load Balancer.
- Private subnet routing through the NAT Gateway.
- DNS resolution using ROute 53.
- CloudFront connectivity.

Expected result:

All network paths operate correctly.

---

# Compute Tests

Verify:

- EC2 instances launch successfully.
- Auto Scaling maintains desired capacity.
- Launch Template is applied.
- Bootstrap script completes successfully.

Expected result:

Instances become healthy within the target group.

---

# Application Load Balancer Tests

Verify:

- Listener configuration.
- Target Group health.
- Healthy targets.
- HTTP request routing.

Expected result:

Traffic is successfully forwarded to healthy EC2 instances.

---

# CloudFront Tests

Verify:

- Distribution status is **Deployed**.
- HTTPS is operational.
- Static assets are served correctly.
- Caching functions correcttly.

Expected result:

CloudFront successfully serves application content.

---

# Route 53 Tests

Verify:

- Hosted Zone exists.
- Alias records exist.
- DNS resolves correctly.
- Domain points to CloudFront.

Expected result:

The configured domain resolves successfully.

---

# ACM Tests

Verify:

- Certificate status is **Issued**.
- DNS validation completed.
- HTTPS is operational.

Expected result:

Secure TLS connections are established.

---

# Amazon S3 Tests

Verify:

- Bucket exists.
- Versioning enabled.
- Encryption enabled.
- Public access blocked.
- Website package uploaded successfully.

Expected result:

CloudFront retrieves website assets successfully.

---

# Security Tests

Verify:

- EC2 instances are inaccessible directly from the Internet.
- Security Group rules are correct.
- IAM permissions follow least privilege.
- HTTPS is enforced.
- S3 objects are inaccessible without CloudFront.

Expected result:

Security controls function as designed.

---

# Auto Scaling Tests

Verify:

- Desired capacity maintained.
- Healthy instances replaced automatically.
- Launch Template used for new instances.
- Scaling policies available.

Expected result:

Auto Scaling maintains application availability.

---

# CloudWatch Tests

Verify:

- Metrics available.
- Health monitoring active.
- Infrastructure reporting correctly.

Expected result:

Operational visibility is available.

---

# Website Validation

Verify:

- Homepage loads.
- CSS loads correctly.
- JavaScript executes correctly.
- Images display correctly.
- Static assets load successfully.
- HTTPS functions correctly.

Expected result:

The website operates normally.

---

# Regression Testing

After every infrastructure modification:

Run:

```bash
terraform fmt -recursive

terraform validate

terraform plan

terraform apply
```

Repeat all operational verification tests.

---

# Test Automation

Infrastructure testing is organised within:

```
tests/
├── infrastructure/
└── terraform/
```

Automated tests should validate:

- Terraform formatting
- Terraform validation
- Infrastructure deployment
- Resource health
- Website accessibility

---

# Acceptance Criteria

The deployment is considered successful when:

- Terraform validation succeeds.
- Infrastructure deploys successfully.
- EC2 instances become healthy.
- ALB health checks pass.
- CloudFront is deployed.
- DNS resolves correctly.
- HTTPS works correctly.
- Website is accessible.
- Security controls are operational.

---

# Test Checklist

Before deployment:

- Terraform formatted
- Validation successful
- Plan reviewed

After deployment:

- Infrastructure healthy
- Website available
- HTTPS operational
- DNS operational
- CloudFront operational
- Auto Scaling healthy
- Monitoring active

---

# Conclusion

The testing strategy ensures that the MathLab AI Infrastructure is validated throughout its lifecycle, from infrastructure provisioning to operational verification. By combining Terraform validation, deployment testing, functional verification, and security testing, the project delivers a reliable, repeatable, and production-oriented cloud infrastructure.
