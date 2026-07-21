# Deployment Guide

## Overview

This document describes the deployment process for the AWS Terraform Infrastructure project.

The infrastructure is provisioned using Terraform Infrastructure as Code (IaC), ensuring repeatable, automated, and consistent deployments.

---

# Deployment Workflow

The deployment process consists of the following stages:

1. Verify prerequisites
2. Configure AWS credentials
3. Initialize Terraform
4. Validate Terraform configuration
5. Generate an execution plan
6. Provision AWS infrastructure
7. Deploy the website
8. Verify infrastructure health
9. Access the website

---

# Prerequisites

Ensure the following software is installed:

- Terraform 1.13 or later
- AWS CLI v2
- Git
- Bash (Linux/macOS or Git Bash on Windows)

Verify the installations:

```bash
terraform version
aws --version
git --version
```

---

# Configure AWS Credentials

Authenticate with AWS using the AWS CLI.

```bash
aws configure
```

Verify authentication:

```bash
aws sts get-caller-identity
```

---

# Initialize Terraform

Navigate to the production environment.

```bash
cd terraform/environments/production
```

Initialize Terraform.

```bash
terraform init
```

---

# Validate the Configuration

Format the Terraform configuration.

```bash
terraform fmt -recursive
```

Validate the configuration.

```bash
terraform validate
```

Generate a deployment plan.

```bash
terraform plan
```

---

# Deploy the Infrastructure

Deploy the AWS infrastructure.

```bash
terraform apply
```

Alternatively, use the automated deployment script.

```bash
make deploy
```

---

# Infrastructure Components

The deployment provisions:

- Amazon VPC
- Public Subnets
- Private Subnets
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

# Website Deployment

The website deployment process is fully automated.

During instance startup:

1. The bootstrap script executes.
2. Nginx is installed.
3. The website archive is downloaded from Amazon S3.
4. The archive is extracted to `/usr/share/nginx/html`.
5. File permissions are configured.
6. Nginx starts automatically.

---

# Verify the Deployment

Run the automated verification script.

```bash
make verify
```

The verification process checks:

- AWS authentication
- Terraform outputs
- S3 bucket accessibility
- Application Load Balancer
- Target Group health
- HTTPS connectivity
- Website availability

---

# Access the Website

Open the deployed website:

```text
https://<your-domain>
```

---

# Update the Website

Create a new website archive.

Upload it to Amazon S3.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

Refresh the Auto Scaling Group.

```bash
aws autoscaling start-instance-refresh \
    --auto-scaling-group-name <asg-name>
```

The new EC2 instances automatically download the updated website during boot.

---

# Destroy the Infrastructure

Destroy all AWS resources.

```bash
make destroy
```

If the S3 bucket contains objects or versioned files, empty the bucket before destroying the infrastructure.

---

# Deployment Summary

The deployment process is fully automated and reproducible.

A new environment can be created using only a few commands, making the project suitable for collaboration, testing, and academic assessment.
