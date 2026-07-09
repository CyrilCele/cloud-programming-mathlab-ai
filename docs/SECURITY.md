# Security Guide

## Overview

Security is a fundamental design principle of the MathLab AI Infrastructure.

The infrastructure has been designed according to AWS security best practices, the principle of least privilege, and Infrastructure as Code (IaC) principles to provide a secure, repeatable, and auditable deployment.

This document describes the security architecture, controls, and operational practices implemented throughout the project.

---

# Security Objectives

The infrastructure is designed to achieve the following objectives:

- Protect infrastructure resources.
- Protect application availability.
- Protect data in transit.
- Protect data at rest.
- Reduce the attack surface.
- Enforce least privilege.
- Support secure operations.
- Enable repeatable secure deployments.

---

# Shared Responsibility Model

Security within AWS follows the Shared Responsibility Model.

AWS is responsible for:

- Physical data centres
- Networking infrastructure
- Hypervisor security
- Hardware maintenance

This project is responsible for:

- IAM configuration
- Network security
- Security Groups
- EC2 configuration
- Operating system updates
- TLS configuration
- S3 permissions
- Terraform configuration

---

# Identity and Access Management

Identity management is implemented using AWS Identity and Access Management (AIM).

The infrastructure includes:

- IAM Role
- IAM Policy
- IAM Instance Profile

No long-term AWS credentials are stored on EC2 instances.

Instead, temporary credentials are automatically provided through the EC2 Instance Profile.

---

# Least Privilege

The project follows the Principle of Least Privilege.

Permissions are granted only where required.

Examples include:

- EC2 instances only access the S3 assets bucket.
- CloudFront only acccesses approved S3 objects.
- Public Internet users never access S3 directly.

---

# Network Security

The network is isolated using Amazon VPC.

Architecture:

![Network Isolation](../images/Network%20Isolation.png)

Only the Application Load Balancer is publicly accessible.

EC2 instances reside within private subnets.

---

# Security Groups

## Application Load Balancer

Inbound

- HTTP (80)
- HTTPS (443)

Outbound

- All outbound traffic

---

## Ec2

Inbound

- HTTP only from the ALB Security Group

Outbound

- All outbound traffic

Direct Internet access to EC2 instances is prohibited.

---

# Data Encryption

## Encryption at Rest

- Amazon S3
- Amazon EBS

Amazon S3 uses:

- AES-256 Server-Side Encryption

EBS volumes are encrypted by default.

---

## Encryption in Transit

HTTPS is used between users and CloudFront.

CloudFront uses TLS 1.2 or later.

AWS Certificate Manager provides managed TLS certificates.

---

# Amazon S3 Security

The assets bucket implements:

- Block Public Access
- Versioning
- Server-Side Encryption
- Lifecycle Configuration
- CloudFront Origin Access Control

Objects cannot be aceessed directly from the public Internet.

---

# CloudFront Security

CloudFront improves both performance and security.

Security controls include:

- HTTPS
- Origin Access Control
- TLS 1.2+
- Cached content isolation

CloudFront is the only approved entry point for static assets.

---

# Route 53 Security

Amazon Route 53 provides:

- Managed DNS
- Alias records
- AWS-native integration

DNS records are managed through Terraform to prevent configuration drift.

---

# AWS Certificate Manager

AWS Certificate Manager provides:

- Automatic certificate management
- DNS validation
- Secure TLS termination

Certificates are integrated directly with CloudFront.

---

# Launch Template Security

The Launch Template implements:

- IMDSv2
- Encrypted EBS volumes
- IAM Instance Profile
- Security Groups
- Cloud-init bootstrap
- Monitoring enabled

IMDSv1 is disabled.

---

# Operating System Security

During bootstrap:

- Operating system packages are updated.
- Security updates are installed.
- Required packages are installed.

Nginx is installed from the Ubuntu repositories.

---

# Auto Scaling Security

Auto Scaling provides:

- Automatic replacement of unhealthy instances
- Consistent instance configuration
- Immutable infrastructure deployment

Every new instance is created from the same Launch Template.

---

# Infrastructure as Code Security

Terraform provides:

- Version control
- Change tracking
- Peer review
- Repeatable deployments

Infrastructure changes should never be performed manually unless required duuring emergency recovery.

---

# Logging and Monitoring

Operational monitoring is provided through Amazon CloudWatch.

Metrics include:

- CPU Utilization
- Network Throughput
- Auto Scaling Activity
- Instance Health

Logs should be reviewed regularly.

---

# Threat Mitigation

![Threat Mitigation](../images/Threat%20Mitigation.png)

---

# Security Best Practices

The project follows these practices:

- Principle of Least Privilege
- Infrastructure as Code
- Security by Default
- Multi-AZ Deployment
- Immutable Infrastructure
- Encryption Everywhere
- Version Control
- Automated Deployment

---

# Security Review Checklist

Before deployment:

- IAM permissions reviewed
- Security Groups validated
- S3 encryption enabled
- Block Public Access enabled
- CloudFront configured
- TLS certificate issued
- Route 53 records validated

After deployment:

- HTTPS working
- EC2 instances private
- ALB healthy
- CloudFront serving requests
- Terraform state secured
- Website accessible

---

# Future Security Improvements

Potential enhancements include:

- AWS WAF
- AWS SHield Advanced
- AWS GuardDuty
- AWS Config
- AWS Security Hub
- Amazon Inspector
- AWS Systems Manager Session Manager
- AWS Secrets Manager

These services were not included because they fail outside the scope of this project.

---

# Conclusion

The MathLab AI Infrastructure incorporates security throughout every layer of the architecture, from networking and identity management to encryption and Infrastructure as Code. By combining AWS-managed security services with disciplined operational practices, the environment provides a strong security posture while remaining maintainable, scalable, and suitable for production-oriented deployments.
