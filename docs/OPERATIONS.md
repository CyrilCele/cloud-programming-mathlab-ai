# Operations Guide

## Overview

This document defines the operational procedures for managing, monitoring, maintaining, and troubleshooting the MathLab AI Infrastructure.

It is intended for cloud engineers, DevOps engineers, and system administrators responsible for the ongoing operation of the AWS environment.

The objectives of this guide are to:

- Maintain service availability.
- Ensure infrastructure security.
- Support operational consistency.
- Minimise downtime.
- Provide standard operating procedures.
- Support incident response.

---

# Operational Responsibilities

Routine operational activities include:

- Monitoring infrastructure health
- Reviewing system logs
- Applying infrastructure updates
- Managing AWS resources
- Monitoring costs
- Performing operational verification
- Responding to incidents

---

# Infrastructure Overview

The deployed environment consists of:

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Security Groups
- IAM
- Amazon S3
- Launch Template
- Auto Scaling Group
- Applciation Load Balancer
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager
- Amazon CloudWatch

---

# Daily Operational Checks

The following checks should be completed regularly.

## Compute

Verify:

- EC2 instances are running.
- Desired Auto Scaling capacity is maintained.
- No failed instance launches.
- No unhealthy instances.

---

## Load Balancer

Confirm:

- Load Balancer is operational.
- Target Group health checks pass.
- Healthy targets match expected capacity.

---

## CloudFront

Verify:

- Distribution status is **Deployed**.
- Requests are successfully served.
- No origin connectivity errors.

---

## Route 53

Confirm:

- DNS records exist.
- DNS resolution succeeds.
- Alias records point to CloudFront.

---

## ACM

Verify:

- Certificate status is **Issued**.
- No validation failures.
- No renewal warnings.

---

## Amazon S3

Review:

- Bucket accessibility.
- Versioning status.
- Encryption configuration.
- Lifecycle policy status.

---

# Monitoring

Amazon CloudWatch provides operational metrics.

Important metrics include:

- CPU Utilization
- Network In
- Network Out
- Disk Read Operations
- Disk Write Operations
- Auto Scaling Activity
- Target Group Health
- ALB Request Count

Monitor trends rather than isolated values.

---

# Auto Scaling Operations

The Auto Scaling Group automatically:

- Launches replacement instances
- Removes unhealthy instances
- Maintains desired capacity
- Responds to scaling policies

Regularly verify:

- Desired Capacity
- Minimum Capacity
- Maximum Capacity
- Instance Health

---

# Website Deployment

When website content changes:

1. Package the website.

```bash
zip -r website.zip website/
```

2. Upload to Amazon S3.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

3. Refresh EC2 instances if necessary.

4. Verify website availability.

---

# CloudFront Cache Management

CloudFront caches static content.

After significant website updates, invalidate cached objects.

```bash
aws cloudfront create-invalidation \
--distribution-id <distribution-d> \
--paths "/*"
```

Verify that new content is served after invalidation.

---

# Infrastructure Updates

Before making changes:

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

Review the execution plan.

Apply approved changes.

```bash
terraform apply
```

---

# Backup Strategy

Infrastructure is defined as code.

Primary backup mechanisms include:

- Git repository
- Terraform configuration
- Terraform state
- S3 Versioning

Website assets are protected through Amazon S3 Versioning.

---

# Logging

Operational logs may be obtained from:

- CloudWatch
- EC2 System Logs
- Nginx Logs
- Auto Scaling Activity History
- Application Load Balancer Access Logs (if enabled)

Review logs after deployments and incidents.

---

# Security Operations

Regularly verify:

- IAM permissions
- Security Group rules
- S3 bucket policies
- CloudFront Origin Access Control
- ACM certificate validity
- Route 53 records

Never expose unnecessary services to the public Internet.

---

# Incident Response

## Website Unavailable

Check:

- CloudFront status
- ALB health
- Target Group health
- EC2 instance status
- Auto Scaling activity
- Nginx service
- Bootstrap logs

---

## EC2 Instance Failure

Auto Scaling should automatically launch a replacement instance.

Confirm:

- Launch Template
- Auto Scaling events
- Health checks

---

## DNS Failure

Verify:

- Route 53 Hosted Zone
- Alias Records
- Name Server configuration
- DNS propagation

---

## Certificate Issues

Confirm:

- ACM certificate status
- DNS validation records
- CloudFront configuration

---

## Website Deployment Failure

Verify:

- website.zip exists.
- S3 upload completed successfully.
- Bootstrap script executed.
- Nginx is running.
- Website files exist in `/var/www/html`.

---

# Operational Verification

After every deployment, confirm:

- Infrastructure deployed successfully.
- Terraform completed without errors.
- EC2 instances are healthy.
- Auto Scaling is operational.
- ALB health checks pass.
- CloudFront serves requests.
- DNS resolves correctly.
- HTTPS is operational.
- Website loads successfully.

---

# Routine Maintenance

Weekly:

- Review CloudWatch metrics.
- Check Auto Scaling activity.
- Review AWS costs.
- Verify website accessibility.

Monthly:

- Review IAM permissions.
- Review Security Groups.
- Validate backups.
- Review Route 53 configuration.
- Verify ACM certificate status.

---

# Cost Monitoring

Monitor:

- EC2 usage
- NAT Gateway charges
- CloudFront traffic
- Route 53 usage
- S3 storage
- CloudWatch usage

Use:

- AWS Cost Explorer
- AWS Budgets
- AWS Billing Dashboard

---

# Operational Best Practices

- Keep Terraform as the single source of truth.
- Never modify infrastructure manually unless required for emergency recovery.
- Commit infrastructure changes to Git before deployment.
- Review every Terraform execution plan.
- Monitor CloudWatch regularly.
- Apply the principle of least privilege.
- Keep project documentation up to date.
- Remove unused AWS resources promptly.

---

# Operational Checklist

Daily:

- Infrastructure healthy
- Website available
- DNS resolving
- CloudFront operational

Weekly:

- Review monitoring
- Review scaling
- Review costs

Monthly:

- Security review
- Documentation review
- Infrastructure review

---

# Conclusion

Following this operational guide ensures that the MathLab AI Infrastructure remains secure, reliable, scalable, and maintainable throughout its lifecycle. By combining Infrastructure as Code with consistent operational practices, the environment can be managed efficiently while reducing operational risk and supporting long-term sustainability.
