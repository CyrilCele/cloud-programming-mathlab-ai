# AWS Terraform Infrastructure Project

## Overview

This project provisions a production-ready AWS infrastructure using **Terraform Infrastructure as Code (IaC)**.

The infrastructure hosts a static website behind a secure, highly available, and scalable AWS architecture while following Infrastructure as Code best practices.

The project was developed as part of a university cloud computing assignment with emphasis on automation, reproducibility, security, and maintainability.

---

# Architecture

The deployed infrastructure includes:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- IAM Instance Profile
- Launch Template
- Auto Scaling Group
- Application Load Balancer
- Amazon EC2 (Amazon Linux 2023)
- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager (ACM)
- Amazon CloudWatch

---

# Repository Structure

```text
.
├── .github/
│   └── workflows/
├── scripts/
├── terraform/
│   ├── environments/
│   ├── modules/
│   └── templates/
├── website/
├── Makefile
└── README.md
```

---

# Prerequisites

Install the following software before deploying the project.

- Terraform >= 1.13
- AWS CLI v2
- Git
- Bash (Git Bash or Linux/macOS terminal)

Configure AWS credentials.

```bash
aws configure
```

Verify authentication.

```bash
aws sts get-caller-identity
```

---

# Quick Start

Clone the repository.

```bash
git clone <repository-url>
cd <repository-folder>
```

Verify prerequisites.

```bash
make prerequisites
```

Deploy the infrastructure.

```bash
make deploy
```

Verify the deployment.

```bash
make verify
```

---

# Deployment Workflow

The deployment performs the following tasks automatically.

1. Verify local dependencies.
2. Initialise Terraform.
3. Format Terraform configuration.
4. Validate Terraform configuration.
5. Generate an execution plan.
6. Provision AWS infrastructure.
7. Configure networking.
8. Launch EC2 instances.
9. Configure Auto Scaling.
10. Configure the Application Load Balancer.
11. Deploy the website from Amazon S3.
12. Validate the deployment.

---

# Quality Assurance

The repository includes automated quality checks.

- Terraform formatting
- Terraform validation
- Terraform planning
- TFLint static analysis
- Checkov security scanning
- Infrastructure verification
- Website verification

Run all quality checks.

```bash
make quality
```

---

# Useful Commands

Initialise Terraform.

```bash
make init
```

Validate configuration.

```bash
make validate
```

Create a deployment plan.

```bash
make plan
```

Deploy infrastructure.

```bash
make deploy
```

Verify infrastructure.

```bash
make verify
```

Destroy infrastructure.

```bash
make destroy
```

Clean Terraform cache.

```bash
make cleanup
```

---

# Automation

The project includes automation scripts located in the `scripts/` directory.

- prerequisites.sh
- deploy.sh
- verify.sh
- destroy.sh
- cleanup.sh
- quality.sh

These scripts simplify deployment and verification, allowing another developer or lecturer to reproduce the environment with minimal manual configuration.

---

# Security Features

The deployment incorporates several security best practices.

- IAM Least Privilege
- Encrypted EBS Volumes
- HTTPS using AWS Certificate Manager
- CloudFront HTTPS distribution
- Private EC2 instances
- Security Groups
- IMDSv2
- S3 Public Access Block
- CloudWatch Monitoring

---

# Testing

Infrastructure verification includes:

- Terraform validation
- Terraform plan
- DNS verification
- ACM certificate validation
- Target Group health checks
- HTTPS verification
- Website accessibility checks

---

# Technologies

- Terraform
- Amazon Web Services (AWS)
- Amazon VPC
- Amazon EC2
- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager
- Elastic Load Balancing
- Auto Scaling
- Amazon CloudWatch
- IAM
- Nginx
- Amazon Linux 2023
- GitHub Actions

---

# Official Documentation

## Terraform

https://developer.hashicorp.com/terraform/docs

## AWS

https://docs.aws.amazon.com/

## Amazon EC2

https://docs.aws.amazon.com/ec2/

## Amazon S3

https://docs.aws.amazon.com/s3/

## Amazon CloudFront

https://docs.aws.amazon.com/cloudfront/

## Amazon Route 53

https://docs.aws.amazon.com/route53/

## Elastic Load Balancing

https://docs.aws.amazon.com/elasticloadbalancing/

## Auto Scaling

https://docs.aws.amazon.com/autoscaling/

## Amazon CloudWatch

https://docs.aws.amazon.com/cloudwatch/

## AWS IAM

https://docs.aws.amazon.com/iam/

## Amazon VPC

https://docs.aws.amazon.com/vpc/

---

# License

This repository was created for academic purposes as part of a university cloud infrastructure project.

This project is licensed under the MIT [License](./LICENSE).

# Author

Nkululeko Cyril Cele
