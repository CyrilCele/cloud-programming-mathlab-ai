# MathLab AI Cloud Infrastructure

## Overview

Infrastructure as Code (IaC) project developed using Terraform to deploy a highly available, scalable web application on AWS.

## Architecture

- VPC
- Public & Private Subnets
- Internet Gateway
- Security Groups
- Launch Template
- Auto Scaling Group
- Application Load Balancer
- CloudWatch
- Amazon S3
- CloudFront
- Route 53

## Requirements

- Terraform >= 1.6
- AWS CLI
- Git

## Deployment

```bash
terraform init
terraform validate
terraform plan
terraform apply
```