# Architecture

## Overview

This document describes the architecture of the AWS Infrastructure project.

The objective is to deploy a static website using a secure, highly available, fault-tolerant, and production-ready AWS infrastructure provisioned entirely with Terraform.

The architecture follows the AWS Well-Architected Framework and Infrastructure as Code (IaC) best practices.

---

# High-Level Architecture

```text
                         Internet
                             │
                             ▼
                       Amazon Route 53
                             │
                             ▼
                    Amazon CloudFront
                             │
                             ▼
                Application Load Balancer
                             │
                             ▼
                  Auto Scaling Group (ASG)
                             │
            ┌────────────────┴────────────────┐
            │                                 │
            ▼                                 ▼
      EC2 Instance (AZ-A)               EC2 Instance (AZ-B)
            │                                 │
            └────────────────┬────────────────┘
                             │
                       Static Website
                             │
                  HTML • CSS • JavaScript
```

---

# Network Architecture

```text
                         AWS Region
┌────────────────────────────────────────────────────────────┐
│                                                            │
│                       Amazon VPC                           │
│                     10.0.0.0/16                            │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  Internet Gateway                    │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                │
│                           ▼                                │
│          ┌──────────────────────────────────┐              │
│          │         Public Route Table       │              │
│          └──────────────────────────────────┘              │
│                   │                       │                │
│                   ▼                       ▼                │
│         Public Subnet A          Public Subnet B          │
│          10.0.1.0/24             10.0.2.0/24              │
│                   │                                       │
│                   ▼                                       │
│              NAT Gateway                                 │
│                   │                                       │
│                   ▼                                       │
│          ┌──────────────────────────────────┐             │
│          │        Private Route Table       │             │
│          └──────────────────────────────────┘             │
│                   │                       │               │
│                   ▼                       ▼               │
│        Private Subnet A          Private Subnet B         │
│         10.0.11.0/24             10.0.12.0/24             │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

# Availability Zone Strategy

The infrastructure is distributed across two Availability Zones within a single AWS Region.

This provides:

- High Availability
- Fault Tolerance
- Load Distribution
- Resilience against Availability Zone failures

The Availability Zones are selected dynamically by Terraform to improve portability between AWS accounts and regions.

---

# Network Components

## VPC

The Virtual Private Cloud provides an isolated network environment for all AWS resources.

CIDR Block:

```text
10.0.0.0/16
```

---

## Public Subnets

Public subnets contain resources that require direct internet connectivity.

Resources deployed here include:

- Application Load Balancer
- NAT Gateway

---

## Private Subnets

Private subnets contain application compute resources.

Resources deployed here include:

- EC2 Instances
- Auto Scaling Group

The private subnets do not have direct internet access.

Outbound internet connectivity is provided through the NAT Gateway.

---

## Internet Gateway

The Internet Gateway enables communication between the VPC and the public internet.

It is attached directly to the VPC.

---

## NAT Gateway

The NAT Gateway enables outbound internet access for resources located in the private subnets.

Typical use cases include:

- Ubuntu package installation
- Operating system updates
- Downloading deployment artifacts

Inbound internet connections to the private subnets are not permitted.

---

## AMazon S3

Amazon S3 is provisioned as a private bucket for storing website assets and future deployment artifacts.

The bucket includes:

- Versioning enabled
- Server-side encryption (AES-256)
- Block Public Access enabled
- Lifecycle configuration to clean up incomplete multipart uploads

The bucket is intentionally provate and is designed for future integration with Amazon CloudFront using Origin Access Control (OAC).

---

# Security Architecture

## Application Load Balancer Security Group

### Inbound

| Protocol | Port | Source    |
| -------- | ---- | --------- |
| TCP      | 80   | 0.0.0.0/0 |
| TCP      | 443  | 0.0.0.0/0 |

### Outbound

All traffic.

---

## EC2 Security Group

### Inbound

| Protocol | Port | Source             |
| -------- | ---- | ------------------ |
| TCP      | 80   | ALB Security Group |

### Outbound

All traffic.

---

## Security Principles

The infrastructure follows the Principle of Least Privilege.

Key characteristics include:

- No public EC2 instances
- No inbound SSH access
- Private compute layer
- Public traffic terminates at the Application Load Balancer
- Dedicated security groups
- Network segmentation using public and private subnets

---

# Terraform Architecture

```text
terraform/
│
├── environments/
│   └── production/
│
└── modules/
    ├── networking/
    ├── iam/
    ├── security-groups/
    ├── s3/
    ├── cloudfront/
    ├── launch-template/
    ├── alb/
    ├── autoscaling/
    ├── cloudwatch/
    ├── route53/
    └── acm/
```

Each module is designed to be:

- Reusable
- Modular
- Environment independent
- Production ready

---

# AWS Well-Architected Framework

## Operational Excellence

- Infrastructure as Code using Terraform
- Modular repository structure
- Version-controlled infrastructure

## Security

- Least Privilege
- Private EC2 instances
- Dedicated Security Groups
- No hardcoded credentials

## Reliability

- Multi-AZ deployment
- NAT Gateway
- Route Tables
- Reusable Terraform modules

## Performance Efficiency

- Amazon S3 for durable static asset storage
- CloudFront module implemented
- CloudFront integration pending Application Load Balancer deployment
- Auto Scaling (planned)
- Application Load Balancer (planned)

## Cost Optimization

- Single NAT Gateway selected to reduce operational costs while maintaining production-grade architecture suitable for this workload.

## Sustainability

- Infrastructure automation
- Elastic scaling (planned)
- Efficient resource provisioning

---

# Current Implementation Status

| Component                 | Status               |
| ------------------------- | -------------------- |
| Repository Structure      | Complete             |
| Networking                | Complete             |
| Security Groups           | Complete             |
| IAM                       | Complete             |
| Amazon S3                 | Complete             |
| CloudFront                | Phase A & B Complete |
| Launch Template           | Complete             |
| Application Load Balancer | Complete             |
| Auto Scaling              | Complete             |
| CloudWatch                | Pending              |
| Route 53                  | Pending              |
| GitHub Actions            | Pending              |
| Production Hardening      | Pending              |
| Deployment                | Pending              |
| Validation                | Pending              |
| Final Submission          | Pending              |

---

# Next Milestone

The next milestone provisions the EC2 Launch Template, including:

- Ubuntu Server
- User Data
- Automatic Nginx installation
- Website deployment
- Automatic service startup
- Reboot persistence
