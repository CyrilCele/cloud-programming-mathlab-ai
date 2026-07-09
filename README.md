# MathLab AI Infrastructure

> Production-grade AWS Infrastructure as Code (IaC) built with Terraform.

---

## Overview

MathLab AI Infrastructure is a cloud-native Infrastructure as Code (IaC) project developed to provision a secure, scalable, highly available, and globally distributed web application environment on Amazon Web Services (AWS).

The project has been designed following production engineering standards rather than tutorial-level examples. Every infrastructure component is modular, reusable, version controlled, and fully documented.

The infrastructure is provisioned entirely using Terraform and follows AWS Well-Architected Framework principles, INfrastructure as Code best practices, least privilege security, and modular software engineering.

This repository forms the cloud infrastructure foundation for the MathLab AI platform.

---

## Project Objectives

The primary objectives of this project are to:

- Provision AWS infrastructure using Infrastructure as Code
- Design a highly available architecture spanning multiple Availability Zones
- Implement secure networking following AWS best practices
- Deploy scalable compute resources using Auto Scaling
- Distribute traffic using an Application Load Balancer
- Improve global performance using Amazon CloudFront
- Secure public traffic using HTTPS with AWS Certificate Manager
- Manage DNS using Amazon Route 53
- Store static deployment artifacts securely using Amazon S3
- Implement least privilege IAM persmissions
- Produce production-quality documentation
- Implement infrastructure validation and testing procedures

---

## Architecture Summary

The deployed infrastructure consists of:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Security Groups
- IAM Roles
- IAM Instance Profiles
- Amazon S3
- EC2 Launch Template
- Auto Scaling Group
- Application Load Balancer
- Amazon CloudFront
- AWS Certificate Manager (ACM)
- Amazon Route 53
- CloudWatch Monitoring

The architecture is fully modular, allowing individual infrastructure components to be maintained independently.

---

## Technology Stack

### Cloud

- Amazon Web Services (AWS)

### Infrastructure as Code

- Terraform

### Compute

- Amazon EC2
- Auto Scaling

### Networking

- Amazon VPC
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups

### Load Balancing

- Application Load Balancer (ALB)

### CDN

- Amazon CloudFront

### DNS

- Amazon Route 53

### Certificates

- AWS Certificate Manager

### Storage

- Amazon S3

### Monitoring

- Amazon CloudWatch

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

## Infrastructure Architecture

The infrastructure follows a layered architecture.

![AWS Infrastructure](./images/Highly%20Available%20Auto-Scaling%20AWS%20Web%20Hosting%20Architecture.png)

---

## Key Features

- Infrastructure as Code
- Modular Terraform Design
- High Availability
- Auto Scaling
- Least Privilege IAM
- CloudFront CDN
- HTTPS Encryption
- Private Networking
- Secure S3 Configuration
- Production Documentation
- Automated Infrastructure Testing

---

## Security Features

The infrastructure implements multiple security controls including:

- Private EC2 instances
- Public ALB only
- Least privilege IAM
- S3 Public Access Block
- Server-side encryption
- HTTPS-only public traffic
- CloudFront Origin Access Control
- IMDSv2
- Encrypted EBS volumes
- Security Group isolation

---

## High Availability

The infrastructure has been designed to eliminate single points of failure.

Features include:

- Multi-AZ deployment
- Auto Scaling Group
- Elastic Load Balancer
- CloudFront Edge Locations
- Route 53 DNS
- Private application subnets

---

## Scalability

Horizontal scaling is achieved using:

- Launch Templates
- Auto Scaling Groups
- Elastic Load Balancer
- CloudFront edge caching

---

## Prerequisites

Before deploying the infrastructure ensure the following software is installed:

- Terraform
- AWS CLIS
- Git
- zip
- SSH

An AWS account with appropriate IAM permissions is required.

---

## Deployment

Terraform workflow:

```bash
terraform init

terraform validate

terraform plan

terraform apply
```

Detailed deployment instructions are provided in [DEPLOYMENT.md](./docs/DEPLOYMENT.md).

---

## Testing

Infrastructure testing includes:

- Terraform validation
- Terraform plan verification
- Infrastructure provisioning validation
- Resource verification
- Network connectivity testing
- DNS validation
- HTTPS validation
- Auto Scaling verification
- CloudFront verification

Detailed testing procedures are documented in [TESTING.md](./docs/TESTING.md).

---

## Cost Considerations

AWS resources used in this project may incur charges.

Primary cost contributors include:

- NAT Gateway
- Route 53 Hosted Zone
- CloudFront
- EC2
- Application Load Balancer

Estimated costs are documented in [COST_ESTIMATION.md](./docs/COST_ESTIMATION.md).

---

## Documentation

Project documentation includes:

- README
- Architecture Guide
- Deployment Guide
- Security Guide
- Testing Guide
- Troubleshooting Guide
- Operational Procedures
- Design Decisions
- Cost Estimation

---

## Future Improvements

Potential future improvements include:

- CI/CD pipeline
- Terraform Cloud
- GitHub Actions
- AWS WAF
- AWS Shield Advanced
- ECS Migration
- Blue/Green Deployment
- Canary Releases
- Secrets Manager
- AWS Config
- GuardDuty
- Security Hub

---

## License

This repository has been developed as part of a university cloud programming project and demonstrates production-grade [Infrastructure as Code (IaC)](https://docs.aws.amazon.com/whitepapers/latest/introduction-devops-aws/infrastructure-as-code.html) practices using [Terraform](https://developer.hashicorp.com/terraform) and [AWS](https://aws.amazon.com/).

This project is licensed under the MIT [License](./LICENSE).

# Author

Nkululeko Cyril Cele
