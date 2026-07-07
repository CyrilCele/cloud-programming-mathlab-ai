# Security Guide

## Overview

This document describes the security controls implemented throughout the AWS Infrastructure project.

The infrastructure follows AWS security best practices and the Security pillar of the AWS Well-Architected Framework.

---

# Security Principles

The infrastructure is designed according to the following principles:

- Principle of Least Privilege
- Defense in Depth
- Secure by Default
- Infrastructure as Code
- No Hardcoded Secrets
- Network Isolation

---

# Identity and Access Management

The infrastructure provisions:

- Dedicated IAM Role for EC2
- EC2 Instance Profile

The role follows the Principle of Least Privilege.

Additional permissions will be granted only when required by future milestones, prventing unnecessary access to AWS services.

---

# Network Security

## Virtual Private Cloud

The infrastructure is deployed inside a dedicated Amazon VPC.

CIDR Block:

```text
10.0.0.0/16
```

---

## Public Subnets

Public subnets host:

- Application Load Balancer
- NAT Gateway

No application workloads are deployed in public subnets.

---

## Private Subnets

Private subnets host:

- EC2 Instances
- Auto Scaling Group

Private subnets are not directly reachable from the internet.

---

## Internet Gateway

Provides internet connectivity for resources deployed in public subnets.

---

## NAT Gateway

Provides outbound internet access for resources deployed in private subnets.

Inbound internet connections are not permitted.

---

# Security Groups

## Application Load Balancer

### Inbound

| Protocol | Port | Source    |
| -------- | ---- | --------- |
| TCP      | 80   | 0.0.0.0/0 |
| TCP      | 443  | 0.0.0.0/0 |

### Outbound

All traffic.

---

## EC2 Instances

### Inbound

| Protocol | Port | Source                                   |
| -------- | ---- | ---------------------------------------- |
| TCP      | 80   | Application Load Balancer Security Group |

### Outbound

All traffic.

---

# SSH Access

Direct SSH access is disabled.

No inbound TCP port 22 is exposed.

Future administrative access can be implemented using AWS Systems Manager Session Manager.

---

# Secrets Management

The repository does not store:

- AWS Access Keys
- Secret Access Keys
- Passwords
- Tokens
- Private Keys

Sensitive configuration must never be committed to Git.

---

# Terraform Security

Terraform follows these security practices:

- No hardcoded credentials
- Variables used for configurable values
- Modular design
- Least privilege resource access
- Environment-specific configuration

---

# Planned Security Enhancements

Future milestones will introduce:

- IAM Roles
- IAM Policies
- EC2 Instance Profiles
- ACM TLS Certificates
- HTTPS-only access
- CloudFront Origin Access Control (OAC)
- CloudWatch monitoring and alarms
- GitHub Actions security scanning

---

# Security Checklist

| Control                        | Status  |
| ------------------------------ | ------- |
| Private EC2 Instances          | ✅      |
| Public ALB Only                | ✅      |
| Least Privilege Network Access | ✅      |
| Dedicated Security Groups      | ✅      |
| No Public SSH                  | ✅      |
| No Hardcoded Credentials       | ✅      |
| Modular Terraform              | ✅      |
| IAM Least Privilege            | Pending |
| HTTPS                          | Pending |
| Encryption at Rest             | Pending |
| CloudWatch Monitoring          | Pending |
