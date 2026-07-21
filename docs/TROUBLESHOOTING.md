# Troubleshooting

## Overview

This document lists common deployment issues and their resolutions.

---

# Terraform Init Fails

## Cause

Terraform backend or provider configuration is incorrect.

## Resolution

Run:

```bash
terraform init -upgrade
```

---

# AWS Authentication Error

## Cause

AWS credentials are missing or invalid.

## Resolution

Configure credentials again.

```bash
aws configure
```

Verify access.

```bash
aws sts get-caller-identity
```

---

# ACM Certificate Stuck in Pending Validation

## Cause

DNS validation record is missing or Route 53 delegation has not propagated.

## Resolution

- Verify the Route 53 hosted zone.
- Confirm the ACM validation CNAME exists.
- Check that the domain uses the correct Route 53 name servers.
- Wait for DNS propagation if changes were recently made.

---

# ALB Returns 502 Bad Gateway

## Cause

The EC2 instances are unhealthy or the web server is not running.

## Resolution

- Verify the bootstrap script completed successfully.
- Check Nginx status.
- Review the target group health.
- Confirm the website was downloaded correctly from Amazon S3.

---

# ALB Returns 403 Forbidden

## Cause

The website files were not extracted correctly or the web root did not contain an `index.html` file.

## Resolution

- Verify the website archive structure.
- Ensure `index.html` is located in the Nginx document root.
- Restart the Auto Scaling instance refresh after uploading the corrected archive.

---

# Website Returns 404 Not Found

## Cause

Website content is missing from the Nginx document root.

## Resolution

- Upload a corrected `website.zip` archive to Amazon S3.
- Start an Auto Scaling Group instance refresh.
- Confirm the bootstrap script downloads and extracts the archive successfully.

---

# EC2 Cannot Download from Amazon S3

## Cause

The IAM Role does not have permission to access the S3 bucket.

## Resolution

Verify the EC2 IAM policy includes:

- `s3:GetObject`
- `s3:ListBucket`

Confirm the instance profile is attached to the Launch Template.

---

# Target Group Health Checks Fail

## Cause

The application is not responding with HTTP 200.

## Resolution

Verify:

- Nginx is running.
- Security Groups allow HTTP traffic from the ALB.
- The health check path is correct.
- The bootstrap script completed successfully.

---

# Useful AWS Commands

List Auto Scaling Groups.

```bash
aws autoscaling describe-auto-scaling-groups
```

Describe Target Health.

```bash
aws elbv2 describe-target-health --target-group-arn <target-group-arn>
```

Describe Load Balancers.

```bash
aws elbv2 describe-load-balancers
```

List Route 53 Hosted Zones.

```bash
aws route53 list-hosted-zones
```

Verify Website.

```bash
curl -I https://<your-domain>
```

---

# Summary

Most deployment issues can be resolved by validating AWS credentials, checking Terraform outputs, reviewing bootstrap logs, confirming IAM permissions, and verifying the health of the Application Load Balancer and EC2 instances.
