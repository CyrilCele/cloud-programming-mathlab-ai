# AWS Highly Available Auto-Scaling Web Hosting Architecture

> Enterprise-grade AWS Infrastructure for hosting a static website using Infrastructure as Code (Terraform).

---

## Overview

This project provisions a production-ready AWS infrastructure for hosting a static website built with HTML, CSS and JavaScript.

The website itself is **not** modified. The focus of this project is designing, provisioning and managing a secure, scalable and highly available AWS infrastructure using Terraform.

The infrastructure follows AWS Well-Architected Framework principles and Infrastructure as Code (IaC) best practices.

---

## Objectives

- Provision infrastructure using Terraform
- Deploy a static website
- Achieve High Availability across multiple Availability Zones
- Follow AWS security best practices
- Use reusable Terraform modules
- Maintain production-ready documentation
- Enable deployment in another AWS account with minimal configuration

---

## Technology Stack

### Cloud

- AWS

### Infrastructure as Code

- Terraform

### Networking

- Amazon VPC
- Internet Gateway
- NAT Gateway
- Route Tables
- Public Subnets
- Private Subnets
- Security Groups

### Compute

- Amazon EC2
- Auto Scaling Group
- Launch Template
- Application Load Balancer

### Content Delivery (Upcoming)

- Amazon S3
- Amazon CloudFront (Upcoming)

### DNS (Upcoming)

- Amazon Route 53

### Monitoring

- Amazon CloudWatch

### Web Server

- Ubuntu Server
- Nginx

### Website

- HTML5
- CSS3
- JavaScript

---

## Repository Structure

```text
mathlab-ai/
│
├── .github/
├── assets/
├── docs/
├── scripts/
├── tests/
├── website/
├── terraform/
│   ├── environments/
│   └── modules/
│
├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── Makefile
└── README.md
```

---

## Current Architecture

![AWS Infrastructure](./Highly%20Available%20Auto-Scaling%20AWS%20Web%20Hosting%20Architecture.png)

### Current Implementation

The following components have been implemented:

- VPC
- Internet Gateway
- NAT Gateway
- Public Subnets
- Private Subnets
- Public Route Table
- Private Route Table
- Route Table Associations
- Application Load Balancer Security Group
- EC2 Security Group
- IAM Role
- EC2 Instance Profile
- Amazon S3
  - Private bucket
  - Server-side encryption (AES-256)
  - Versioning enabled
  - Block Public Access enabled
  - Lifecycle configuration
- Application Load Balancer
- Target Group
- HTTP Listener
- Amazon CloudFront
- Auto Scaling Group
- CloudWatch Log Group
- CloudWatch Monitoring
- CloudWatch Alarms

---

## Networking Design

### Public Subnets

Used for:

- Internet Gateway
- NAT Gateway
- Application Load Balancer

### Private Subnets

Used for:

- EC2 Instances
- Auto Scaling Group

Private instances are not directly accessible from the Internet.

Outbound connectivity is provided through the NAT Gateway.

---

## Security

Current security controls include:

- Principle of Least Privilege
- Private EC2 architecture
- Dedicated security groups
- No inbound SSH access
- Internet traffic terminates at the Application Load Balancer
- Common resource tagging
- No hardcoded credentials
- No hardcoded AWS account IDs

---

## Terraform Modules

| Module          | Status               |
| --------------- | -------------------- |
| Networking      | Complete             |
| Security Groups | Complete             |
| IAM             | Complete             |
| S3              | Complete             |
| CloudFront      | Phase A & B Complete |
| Launch Template | Complete             |
| ALB             | Complete             |
| Auto Scaling    | Complete             |
| CloudWatch      | Complete             |
| Route 53        | Pending              |
| ACM             | Pending              |

---

## Deployment Prerequisites

- AWS Account
- AWS CLI
- Terraform 1.13+
- Git

---

## Initial Deployment

```bash
git clone <repository>

cd mathlab-ai

cp terraform/environments/production/terraform.tfvars

cd terraform/environments/production

terraform init

terraform validate

terraform plan

terraform apply
```

---

## Project Status

| Milestone                 | Status               |
| ------------------------- | -------------------- |
| Repository Initialization | Complete             |
| Networking                | Complete             |
| IAM                       | Complete             |
| Amazon S3                 | Complete             |
| CloudFront                | Phase A & B Complete |
| Launch Template           | Complete             |
| Application Load Balancer | Complete             |
| Auto Scaling              | Complete             |
| CloudWatch                | Complete             |
| Route 53                  | Pending              |
| GitHub Actions            | Pending              |
| Production Hardening      | Pending              |
| Deployment                | Pending              |
| Validation                | Pending              |
| Final Submission          | Pending              |

---

## Documentation

Project documentation is available in the `docs/` directory.

- ARCHITECTURE.md
- DEPLOYMENT.md
- SECURITY.md
- TESTING.md
- TROUBLESHOOTING.md
- DECISIONS.md
- COST_ESTIMATION.md
- OPERATIONS.md

---

## License

This project is licensed under the MIT [License](./LICENSE).

# Author

Nkululeko Cyril Cele
