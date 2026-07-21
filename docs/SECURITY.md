# Security

## Overview

Security is implemented throughout the infrastructure using AWS security best practices.

The deployment follows the principle of least privilege while protecting both infrastructure and application resources.

---

# IAM

IAM Roles are used instead of long-term access keys.

EC2 instances receive permissions through an IAM Instance Profile.

The IAM policy grants only the permissions required for:

- Amazon S3
- CloudWatch Logs
- CloudWatch Metrics

---

# Network Security

Security Groups restrict inbound and outbound traffic.

Application Load Balancer

- HTTP (80)
- HTTPS (443)

EC2 Instances

- HTTP only from the ALB Security Group

No direct public access is permitted to EC2 instances.

---

# Encryption

Encryption is enabled for:

- Amazon EBS volumes
- HTTPS traffic
- ACM SSL/TLS certificate

---

# S3 Security

The S3 bucket includes:

- Block Public Access
- Server-side encryption
- Versioning
- IAM-based access

Website files are accessed only by authorised AWS services.

---

# Instance Security

EC2 instances use:

- Amazon Linux 2023
- IMDSv2
- Private subnets
- IAM Instance Profiles

---

# HTTPS

HTTPS is implemented using:

- AWS Certificate Manager
- Amazon CloudFront
- Route 53

All user traffic is encrypted.

---

# Monitoring

Amazon CloudWatch monitors:

- CPU utilisation
- Instance health
- Load Balancer health
- Application metrics

CloudWatch Alarms generate notifications when thresholds are exceeded.

---

# Terraform Security

Security validation includes:

- Terraform Validate
- TFLint
- Checkov

These tools identify configuration errors and security risks before deployment.

---

# Security Summary

The project applies multiple layers of defence, including IAM, network isolation, encryption, monitoring, and automated validation to provide a secure and production-ready AWS environment.
