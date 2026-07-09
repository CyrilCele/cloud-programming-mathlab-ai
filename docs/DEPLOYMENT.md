# Deployment Guide

## Overview

This document describes the complete deployment process for the MathLab AI Infrastructure using Terraform.

The deployment provisions all AWS resources required for a production-ready environment, including networking, security, compute, storage, content delivery, monitoring, DNS, and SSL/TLS.

This guide assumes that the infrastructure is deployed from a Linux, macOS, or Windows workstation with the required software installed.

---

# Deployment Architecture

The deployment provisions the following AWS services:

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Security Groups
- IAM
- Amazon S3
- Launch Template
- Auto Scaling Group
- Application Load Balancer
- Amazon CloudFront
- AWS Certificate Manager
- Amazon Route 53
- Amazon CloudWatch

---

# Prerequisites

Before deploying, ensure the following requirements are met.

## AWS Account

An active AWS account with permissions to create infrastructure resources.

---

## AWS CLI

Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

Verify installation.

```bash
aws --version
```

---

## Terraform

Install [Terraform](https://developer.hashicorp.com/terraform/install).

Verify installation.

```bash
terraform version
```

---

## Git

Clone the project repository.

```bash
git clone https://github.com/CyrilCele/cloud-programming-mathlab-ai

cd mathlab-ai
```

---

# Configure AWS Credentials

Authenticate using AWS CLI.

```bash
aws configure
```

Provide:

- AWS Access Key ID
- AWS Secret Access Key
- Default Region
- Output Format

Verify access.

```bash
aws sts get-caller-identity
```

---

# Project Structure

Navigate to the production environment.

```bash
cd terraform/environments/production
```

---

# Configure Variables

Review and update the Terraform variables.

```text
terraform.tfvars
```

Typical values include:

- AWS Region
- Enviromnment
- Project Name
- VPC CIDR
- Subnet CIDRs
- EC2 Instance Type
- S3 Bucket Name
- Domain Name

---

# Initialize Terraform

Download providers and initialize the working directory.

```bash
terraform init
```

Expected result:

```
Terraform has been successfully initialized.
```

---

# Format Configuration

Ensure consistent formatting.

```bash
terraform fmt -recursive
```

---

# Validate Configuration

Validate the Terraform configuration.

```bash
terraform validate
```

Expected output:

```
Success! The configuration is valid.
```

---

# Generate Execution Plan

Preview the infrastructure changes.

```bash
terraform plan
```

Carefully review:

- Resources to create
- Resources to modify
- Resources to destroy

No unexpected changes should appear.

---

# Deploy Infrastructure

Provision the infrastructure.

```bash
terraform apply
```

Approve the execution.

```
yes
```

Terraform will provision all AWS resources.

Deployment time may range from several minutes to over twenty minutes depending on AWS service provisioning times.

---

# Verify Deployment

After deployment, confirm that the following resources exist:

## Networking

- VPC
- Public Subnets
- Private Subnets
- NAT Gateway
- Route Tables

---

## Compute

- Launch Template
- Auto Scaling Group
- EC2 Instances

---

## Storage

- Amazon S3 Bucket

---

## Load Balancing

- Application Load Balancer

---

## CDN

- CloudFront Distribution

---

## DNS

- Route 53 Hosted Zone
- Route 53 Records

---

## SSL

- ACM Certificate

---

# Upload Website

Package the website.

```bash
zip-r website.zip website/
```

Upload to Amazon S3.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

---

# Bootstrap Verification

The EC2 bootstrap script automatically:

- Updates the operating system
- Installs Nginx
- Installs AWS CLI
- Downloads the website package
- Extracts website files
- Configures permissions
- Starts Nginx

Confirm successful execution through:

- EC2 System Logs
- CloudWatch Logs (if enabled)
- SSH troubleshooting (if applicable)

---

# Validate Application

Open the application using:

- CloudFront URL
- Custom domain (if configured)

Confirm:

- Website loads successfully
- HTTPS is enabled
- Static assets load correctly
- Images display correctly
- CSS loads correctly
- JavaScript functions correctly

---

# Terraform Outputs

Display deployment outputs/

```bash
terraform output
```

Useful outputs include:

- ALB DNS Name
- CloudFront Domain Name
- Route 53 Hosted Zone ID
- ACM certificate ARN
- s3 Bucket Name

---

# Updating Infrastructure

After modifying Terraform:

```bash
terraform fmt -recursive

terraform validate

terraform plan

terraform apply
```

Always review the execution plan before applying changes.

---

# Updating Website Content

Create a new archive.

```bash
zip -r website.zip website/
```

Upload the updated archive.

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

Recycle EC2 instances if required to trigger the bootstrap process, or implement an automated deployment pipeline for production environments.

---

# Destroy Infrastructure

To remove all AWS resources:

```bash
terraform destroy
```

Confirm the operation.

```
yes
```

Verify in the AWS Management Console that all billable resources have been removed.

---

# Common Deployment Issues

## Terraform Validation Errors

Run:

```bash
terraform validate
```

Review the reported file and line number.

---

## AWS Authentication Failure

Verify:

```bash
aws sts get-caller-identity
```

---

## ACM Certificate Pending Validation

Ensure:

- Route 53 validation records exist.
- DNS propagation has completed.

---

## CloudFront Not Updating

Invalidate the cache.

```bash
aws cloudfront create-invalidation \
--distribution-id <distribution-id> \
--paths "/*"
```

---

## EC2 Website Not Loading

Check:

- Auto Scaling Group
- Target Group health
- Security Groups
- Nginx status
- Bootstrap logs

---

# Deployment Checklist

Before deployment:

- AWS credentials configured
- Terraform installed
- AWS CLI installed
- Variables reviewed
- Domain configured
- Website packaged

After deployment:

- Infrastructure healthy
- EC2 instances running
- ALB healthy
- CloudFront operational
- DNS resolving correctly
- HTTPS working
- Website accessible

---

# Conclusion

Following this deployment guide results in a fully provisioned AWS infrastructure built using Terraform and aligned with Infrastructure as Code best practices. The documented workflow ensures deployments are repeatable, auditable, and suitable for production-oriented engineering practices.
