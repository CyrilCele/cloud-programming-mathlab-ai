# Architecture

## Overview

This project provisions a highly available, secure, and scalable AWS infrastructure using Terraform Infrastructure as Code (IaC).

The infrastructure follows AWS Well-Architected Framework principles and is designed to automate deployment while remaining reproducible and maintainable.

---

# High-Level Architecture

![Architecture](../images/Highly%20Available%20Auto-Scaling%20AWS%20Web%20Hosting%20Architecture.png)

---

# Infrastructure Components

## Networking

The networking layer consists of:

- Amazon VPC
- Two Public Subnets
- Two Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

Public subnets host internet-facing resources, while EC2 instances remain in private subnets.

---

## Compute

Application compute resources include:

- Amazon Linux 2023
- Launch Template
- Auto Scaling Group

Each EC2 instance automatically executes a bootstrap script that installs Nginx and deploys the website.

---

## Storage

Amazon S3 stores the compressed website archive.

During boot, EC2 instances download and extract the archive before starting Nginx.

---

## Load Balancing

An Application Load Balancer distributes traffic across EC2 instances.

Benefits include:

- High availability
- Fault tolerance
- Automatic health checks

---

## DNS

Amazon Route 53 provides DNS management.

AWS Certificate Manager issues the SSL/TLS certificate used for HTTPS.

---

## Content Delivery

Amazon CloudFront accelerates global content delivery and serves HTTPS traffic using the ACM certificate.

---

## Monitoring

Amazon CloudWatch provides:

- Metrics
- Logs
- Health monitoring
- CloudWatch Alarms
- SNS Notifications

---

## Security

Security controls include:

- IAM Roles
- IAM Instance Profile
- Security Groups
- Private EC2 instances
- HTTPS
- IMDSv2
- Encrypted EBS volumes
- S3 Public Access Block

---

# Deployment Flow

1. Terraform provisions AWS resources.
2. Auto Scaling launches EC2 instances.
3. Bootstrap installs Nginx.
4. Website archive downloads from Amazon S3.
5. Website is extracted.
6. Nginx starts.
7. ALB health checks pass.
8. CloudFront serves HTTPS traffic.
9. Route 53 directs users to the application.

---

# Architecture Principles

The project follows:

- Infrastructure as Code
- Modular Terraform design
- High Availability
- Scalability
- Least Privilege
- Reproducibility
- Automation
- Maintainability
