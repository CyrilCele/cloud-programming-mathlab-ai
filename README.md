# AWS Highly Available Auto-Scaling Web Hosting Architecture

> Enterprise-grade AWS Infrastructure for hosting a static website using Infrastructure as Code (Terraform).

---

# Project Overview

This project provisions a product-ready AWS infrastructure capable of hosting an static (HTML, CSS< and JavaScript>) website. The infrastructure is designed using AWS best practices and follows the AWS Well-Architected Framework to provide high availability, security, scalability, reliability, maintainability, and low-latency content delivery.

The website itself is **not** the focus of this project. It represents the workload that will be deployed to the AWS infrastructure. All infrastructure resources are provisioned and managed using Terraform to ensure repeatability, consistency, and ease of deployment across AWS accounts.

---

# Project Objectives

The primary objectives of this project are to:

- Provision all AWS resources using Terraform.
- Deploy a static website without modifying its source code.
- Build a highly available and fault-tolerant architecture.
- Implement secure networking and identity management.
- Automate infrastructure deployment.
- Follow AWS and HashiCorp best practices.
- Produce professional documentation suitable for engineering handover and academic assessment.

---

# Target Architecture

This infrastructure implements the following architecture:

```text
Internet Users
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
Auto Scaling Group
        │
        ▼
Amazon EC2 Instances
        │
        ▼
Nginx
        │
        ▼
Static HTML/CSS/JavaScript Website
```

Additional AWS services provide networking, storage, monitoring, identity management, and security.

A detailed architecture diagram is included in `/assets` and described in `docs/ARCHITECTURE.md`.

---

# Technology Stack

## Cloud Platform

- Amazon Web Services (AWS)

## Infrastructure as Code

- Terraform

## Web Server

- Nginx
- Ubuntu Server

## Application

- HTML5
- CSS3
- JavaScript

## Networking

- Amazon VPC
- Internet Gateway
- Route Tables
- Security Groups

## Compute

- Amazon EC2
- Auto-Scaling Group
- Launch Template
- Application Load Balancer

## Storage

- Amazon S3

## Content Delivery

- Amazon CloudFront

## DNS

- Amazon Route 53

## Monitoring

- Amazon CloudWatch

## Identity and Access Management

- AWS IAM

## Version Control

- Git
- GitHub

---

# Repository Structure

```text
mathlab-ai/

├── .github/
├── assets/
├── docs/
├── scripts/
├── tests/
├── terraform/
├── website/

├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── Makefile
└── README.md
```

Each directory has a dedicated responsibility and is documented throughout this project.

---

# AWS Well-Architected Framework

The infrastructure is designed to align with all six pillars of the AWS Well-Architected Framework.

- Operational Excellence
- Security
- Reliability
- Performance Efficiency
- Cost Optimization
- Sustainability

Architectural decisions mad throughout the project identify which pillar(s) they support.

---

# Infrastructure as Code

All AWS resources are provisioned using Terraform.

The project emphasizes:

- Reusable modules
- Parameterized configuration
- Environment-specific deployment
- Secure handling of sensitive variables
- Consistent and repeatable infrastructure provisioning

Manual configuration is avoided unless explicitly required by AWS.

---

# Website Deployment

The website is stored in the `website/` directory. The website source code is **not modified** during this project. Instead, Terraform provisions the required infrastructure while EC2 User Data automatically:

- installs Nginx,
- deploys the website,
- configures the web server, and
- starts required services.

This approach separates infrastructure from application code and simplifies website updates.

---

# Documentation

Project documentation is maintained throughout development.

| Document             | Purpose                                    |
| -------------------- | ------------------------------------------ |
| `ARCHITECTURE.md`    | Infrastructure design and AWS architecture |
| `DEPLOYMENT.md`      | Deployment guide                           |
| `SECURITY.md`        | Security controls and best practices       |
| `TESTING.md`         | Infrastructure validation procedures       |
| `TROUBLESHOOTING.md` | Common issues and resolutions              |
| `DECISIONS.md`       | Architecture Decision Records (ADRs)       |
| `COST_ESTIMATION.md` | Estimated AWS infrastructure costs         |
| `OPERATIONS.md`      | Operational procedures and maintenance     |

Each document is updated as new milestones are completed.

# Project Status

Current Progress

- Repository initialization in progress.
- Documentation established.
- Terraform bootstrap pending.
- Newtworking pending.
- Compute infrastructure pending.
- Monitoring pending.
- DNS pending.

Progress will be updated after every milestone.

# License

This project is licensed under MIT License.

See the `LICENSE` file for details.

# Author

Nkululeko Cyril Cele
