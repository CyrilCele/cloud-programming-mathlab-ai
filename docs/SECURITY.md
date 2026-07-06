# Security Guide

This document describes the security architecture, controls, and best practices implemented throughout the AWS Static Website Infrastructure project.

Security is incorporated into every layer of the infrastructure and follows the AWS Well-Architected Framework Security Pillar.

---

# Security Objectives

The infrastructure is designed to achieve the following security objectives:

- Protect infrastructure resources.
- Protect application availability.
- Protect data at rest and in transit.
- Minimize the attack surface.
- Follow the Principle of Least Privilege.
- Ensure repeatable and auditable deployments.
- Prevent exposure of sensitive information.

---

# Security Principles

The project follows these core security principles:

- Least Privilege
- Defense in Depth
- Secure by Default
- Infrastructure as Code
- Encryption by Default
- Identity-Based Access Control
- Continuous Monitoring

---

# Identity and Access Management (IAM)

AWS Identity and Access Management (IAM) is used to control access to AWS resources.

The project implements:

- IAM Roles
- IAM Policies
- EC2 Instance Profiles

No AWS credentials are stored on EC2 instances.

Long-term access keys are avoided wherever possible.

---

# Network Security

The networking layer is designed to reduce unnecessary exposure.

Security measures include:

- Virtual Private Cloud (VPC)
- Public and private network segmentation (where applicable)
- Security Groups
- Restrictive ingress and egress rules
- Internet Gateway
- Route Tables

Only required network ports are opened.

---

# Security Groups

Security Groups provide stateful firewall protection.

The project follows these principles:

- Deny unnecessary traffic.
- Allow only required inbound traffic.
- Restrict outbound traffic where practical.
- Separate Security Groups by resource responsibility.

---

# Data Protection

Sensitive information must never be committed to version control.

Protected files include:

- terraform.tfvars
- Terraform state files
- Private keys
- Certificates
- AWS credentials

The project's `.gitignore` prevents accidental commits of these files.

---

# Encryption

Encryption is enabled wherever supported by AWS services.

Examples include:

- Amazon S3
- CloudFront HTTPS
- AWS-managed encryption services

Additional encryption configurations will be documented as infrastructure components are implemented.

---

# Infrastructure as Code Security

Terraform provides a repeatable and auditable deployment process.

Security benefits include:

- Version-controlled infrastructure
- Peer-review capability
- Reduced configuration drift
- Consistent deployments
- Repeatable provisioning

---

# Website Security

The existing website remains unchanged.

Infrastructure security is implemented independently of the website source code.

Nginx is configured to securely serve the static website after EC2 provisioning.

---

# Logging and Monitoring

Monitoring is implemented using Amazon CloudWatch.

Monitoring includes:

- Infrastructure metrics
- System health
- Performance monitoring
- Alarm generation

Additional monitoring configurations will be added during the CloudWatch milestone.

---

# Security Best Practices

The project follows AWS best practices by:

- Using IAM Roles instead of access keys.
- Applying the Principle of Least Privilege.
- Restricting network access.
- Avoiding hardcoded credentials.
- Encrypting supported resources.
- Using Infrastructure as Code.
- Maintaining version control.
- Performing infrastructure validation before deployment.

---

# Security Responsibilities

| Component       | Responsibility                 |
| --------------- | ------------------------------ |
| IAM             | Identity and access management |
| Security Groups | Network traffic filtering      |
| VPC             | Network isolation              |
| CloudFront      | Secure content delivery        |
| S3              | Secure object storage          |
| CloudWatch      | Monitoring and alerting        |
| Terraform       | Infrastructure provisioning    |

---

# Security Compliance

The infrastructure is designed to align with the AWS Well-Architected Framework Security Pillar by implementing:

- Identity management
- Network protection
- Secure infrastructure provisioning
- Encryption
- Monitoring
- Least privilege access

---

# Future Updates

This document will be expanded as additional infrastructure components are implemented.

Future milestones will document:

- IAM policies
- Security Group rules
- S3 bucket policies
- CloudFront Origin Access Control (OAC)
- HTTPS configuration
- Encryption settings
- Monitoring and alarms
- Production hardening

---

# Current Status

| Security Component    | Status     |
| --------------------- | ---------- |
| Security Principles   | ✅ Defined |
| IAM                   | ⏳ Pending |
| Security Groups       | ⏳ Pending |
| Encryption            | ⏳ Pending |
| CloudWatch Monitoring | ⏳ Pending |
| CloudFront Security   | ⏳ Pending |
| Production Hardening  | ⏳ Pending |
