# Cost Estimation

## Overview

This document provides an estimated monthly cost for the AWS infrastructure.

Actual costs depend on:

- AWS Region
- Traffic volume
- Data transfer
- Compute usage
- Storage consumption

---

# Current Infrastructure

| Service          | Quantity |
| ---------------- | -------: |
| Amazon VPC       |        1 |
| Internet Gateway |        1 |
| NAT Gateway      |        1 |
| Elastic IP       |        1 |
| Public Subnets   |        2 |
| Private Subnets  |        2 |
| Route Tables     |        2 |
| Security Groups  |        2 |
| Amazon S3 Bucket |        1 |

---

# Planned Infrastructure

| Service                   |
| ------------------------- |
| EC2                       |
| Launch Template           |
| Auto Scaling Group        |
| Application Load Balancer |
| Amazon CloudFront         |
| Amazon Route 53           |
| Amazon CloudWatch         |
| AWS Certificate Manager   |

---

# Major Cost Drivers

## NAT Gateway

The NAT Gateway is expected to be one of the largest recurring networking costs.

A single NAT Gateway has been selected to balance:

- Production readiness
- Cost optimization
- Simplicity

---

## EC2 Instances

Compute costs depend on:

- Instance type
- Number of running instances
- Auto Scaling configuration

---

## CloudFront

CloudFront costs depend on:

- Requests
- Data transfer
- Cache hit ratio

---

## Application Load Balancer

Costs depend on:

- Running hours
- Load Balancer Capacity Units (LCUs)

---

# Cost Optimization Decisions

The project incorporates the following cost optimization strategies:

- Single NAT Gateway
- Auto Scaling (planned)
- CloudFront caching (planned)
- Infrastructure as Code
- Modular Terraform
- Resource tagging

---

# AWS Well-Architected Cost Optimization

The infrastructure is designed to:

- Avoid unnecessary resources
- Scale automatically
- Minimize operational overhead
- Support efficient resource utilization

---

# Estimated Monthly Cost

A detailed cost estimate will be completed after all infrastructure components have been implemented in later milestones using the AWS Pricing Calculator.
