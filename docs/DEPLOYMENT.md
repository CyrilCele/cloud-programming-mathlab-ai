# Deployment Guide

## Overview

This document describes how to deploy the Static Website on AWS Infrastructure using Terraform.

The infrastructure is designed to be fully reproducible and deployable in any AWS account with minimal configuration.

---

# Prerequisites

Before deploying the infrastructure, ensure the following software is installed.

## Required Software

- Git
- AWS CLI v2
- Terraform 1.13 or later

Verify the installations.

```bash
git --version

aws --version

terraform version
```

---

# AWS Account Requirements

You must have:

- An active AWS account
- Permissions to provision AWS resources
- AWS CLI configured with valid credentials

---

# Configure AWS CLI

Configure your AWS credentials.

```bash
aws configure
```

Provide:

- AWS Access Key ID
- AWS Secret Access Key
- Default AWS Region
- Output format

Verify authentication.

```bash
aws sts get-caller-identity
```

---

# Clone the Repository

Clone the repository.

```bash
git clone <repository-url>

cd mathlab-ai
```

---

# Repository Structure

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

# Configure Terraform Variables

Navigate to the production environment.

```bash
cd terraform/environments/production
```

Copy the example variables file.

```bash
cp terraform.tfvars
```

Update the values inside `terraform.tfvars`.

Example:

```hcl
aws_region = "af-south-1"

environment = "production"

project_name = "aws-static-website"

assets_bucket_name = "my-company-static-assets"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidr_a = "10.0.1.0/24"
public_subnet_cidr_b = "10.0.2.0/24"

private_subnet_cidr_a = "10.0.11.0/24"
private_subnet_cidr_b = "10.0.12.0/24"
```

---

# Initialize Terraform

Initialize the working directory.

```bash
terraform init
```

Terraform downloads:

- AWS Provider
- Required modules
- Backend configuration

---

# Validate Configuration

Validate the Terraform configuration.

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

# Format Configuration

Ensure all Terraform files follow the official formatting standard.

```bash
terraform fmt -recursive
```

---

# Review the Execution Plan

Generate an execution plan.

```bash
terraform plan
```

Review all planned changes before applying them.

---

# Deploy the Infrastructure

Deploy the infrastructure.

```bash
terraform apply
```

Terraform will prompt for confirmation.

Type:

```text
yes
```

Terraform will provision all configured AWS resources.

---

# Verify the Deployment

After deployment, verify:

- VPC created
- Public Subnets created
- Private Subnets created
- Internet Gateway attached
- NAT Gateway created
- Route Tables created
- Security Groups created

---

# Current Infrastructure

The infrastructure currently provisions:

- Amazon VPC
- Internet Gateway
- NAT Gateway
- Public Route Table
- Private Route Table
- Public Subnets
- Private Subnets
- Route Table Associations
- Application Load Balancer Security Group
- EC2 Security Group
- IAM Role
- EC2 Instance Profile
- Amazon S3

---

# Planned Infrastructure

Future milestones will provision:

- IAM
- Amazon S3
- CloudFront
- Launch Template
- EC2
- Auto Scaling Group
- Application Load Balancer
- CloudWatch
- Route 53
- ACM

---

# Destroy Infrastructure

To remove all infrastructure:

```bash
terraform destroy
```

Confirm by typing:

```text
yes
```

---

# Troubleshooting

Refer to the [TROUBLESHOOTING](./TROUBLESHOOTING.md) file.

---

# Deployment Workflow

```text
Clone Repository
        │
        ▼
Configure AWS CLI
        │
        ▼
Configure terraform.tfvars
        │
        ▼
terraform init
        │
        ▼
terraform fmt
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
Verify AWS Resources
```

---

# Milestone Status

| Milestone                 | Status   |
| ------------------------- | -------- |
| Repository Initialization | Complete |
| Networking                | Complete |
| IAM                       | Complete |
| Amazon S3                 | Complete |
| CloudFront                | Pending  |
| Launch Template           | Pending  |
| Application Load Balancer | Pending  |
| Auto Scaling              | Pending  |
| CloudWatch                | Pending  |
| Route 53                  | Pending  |
| GitHub Actions            | Pending  |
| Production Hardening      | Pending  |
| Deployment                | Pending  |
| Validation                | Pending  |
| Final Submission          | Pending  |
