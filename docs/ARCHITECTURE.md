# Architecture

## Overview

The MathLab AI Infrastructure has been designed using Infrastructure as Code (IaC) principles to provide a secure, scalable, highly available, and maintainable cloud environment on Amazon Web Services (AWS).

The solution adopts a modular Terraform architecture where each AWS service is encapsulated within its own reusable module. This approach promotes maintainability, code reuse, separation of concerns, and simplified lifecycle management.

The deployed infrastructure follows AWS Well-Architected Framework principles, emphasizing:

- Operational Excellence
- Security
- Reliability
- Performance Efficiency
- Cost Optimisation
- Sustainability

---

# High-Level Architecture

![Infrastructure-UML](../images/Highly%20Available%20Auto-Scaling%20AWS%20Web%20Hosting%20Architecture.png)

The infrastructure is distributed across multiple Availability Zones to eliminate single points of failure.

---

# Infrastructure Layers

The architecture has been divided into several logical layers.

## Edge Layer

Responsible for serving end users.

Components

- Amazon Route 53
- Amazon CloudFront
- AWS Certificate Manager

Responsibilities

- DNS resolution
- HTTPS termination
- Global caching
- Static asset delivery
- Low latency content distribution

---

## Load Balancing Layer

Responsible for traffic distribution.

Component

- Application Load Balancer

Responsibilities

- Health checks
- Traffic routing
- High availability
- Request distribution

---

## Compute Layer

Responsible for application execution.

Components

- Launch Template
- Auto Scaling Group
- Amazon EC2

Responsibilities

- Website hosting
- Automatic scaling
- Self0healing infrastructure
- Immutable infrastructure deployment

---

## Storage Layer

Component

- Amazon S3

Responsibilities

- Website deployment package
- Static assets
- Versioned object storage
- Secure artifact storage

---

## Security Layer

Components

- IAM
- Security Groups
- S3 Encryption
- CloudFront Origin Access Control
- IMDSv2
- EBS Encryption

Responsibilities

- Authentication
- Authorization
- Network isolation
- Encryption
- Least privilege access

---

# Network Architecture

The network is built using Amazon Virtual Private Cloud (VPC).

Components

- One VPC
- Two Public Subnets
- Two Private Subnets
- Internet Gateway
- NAT Gateway
- Public Route Table
- Private Route Table

Public resources include:

- Application Load Balancer
- NAT Gateway

Private resources include:

- EC2 instances

This design prevents direct Internet access to application servers while allowing outbound connectivity for operating system updates and package installation.

---

# Availability Strategy

The infrastructure is designed to tolerate Availability Zone failures.

Measures include:

- Multiple public subnets
- Multiple private subnets
- Multi-AZ Auto Scaling
- Multi-AZ Load Balancer
- CloudFront edge network
- Route 53 global DNS

This architecture minimizes downtime during infrastructure failures.

---

# Scalability Strategy

Horizontal scaling is implemented using Auto Scaling Groups.

Scaling decisions are based on CloudWatch metrics.

The Launch Template ensures every new instacne is configured identically.

Benefits include:

- Elastic capacity
- Automatic recovery
- Consistent deployments
- Reduced operational overhead

---

# Security Architecture

The infrastructure follows the principle of least privilege.

## IAM

EC2 instances receive permissions using IAM Roles instead of long-term credentials.

## Network Security

Aplication traffic follows the path:

![Network Security](../images/Network%20Security.png)

Direct Internet access to EC2 instances is prohibited.

## Encryption

Data at rest

- Enhanced EBS volumes
- Encrypted S3 bucket

Data in transit

- HTTPS
- TLS 1.2+
- CloudFront encryption

## S3 Protection

The assets bucket includes:

- Public Access Block
- Versioning
- Server-side encryption
- Lifecycle management
- CloudFront Origin Access Control

---

# DNS Architecture

Amazon Route 53 manages public DNS records.

Responsibilities include:

- Domain resolution
- Alias records
- CloudFront integration

The DNS layer routes client traffic directly to CloudFront.

---

# Content Delivery

Amazon CloudFront improves:

- Global performance
- Static asset caching
- HTTPS delivery
- Reduced origin load

CloudFront retrieves static assets securely from Amazon S3 using Origin Access Control.

Dynamic application traffic is forwarded to the Application Load Balancer.

---

# Deployment Workflow

Infrastructure deployment follows this sequence.

1. Terraform initialization
2. Infrastructure validation
3. Infrastructure planning
4. Resource provisioning
5. ACM validation
6. Route 53 configuration
7. Website artifact upload
8. Auto Scaling deployment
9. Infrastructure verification
10. Operational testing

---

# Terraform Module Architecture

Each infrastructure component is isolated into its own module.

Modules include:

- networking
- security-group
- iam
- s3
- alb
- launch-template
- autoscaling
- cloudfront
- acm
- cloudwatch
- route53-zone
- route53-records

Advantages

- High cohesion
- Low coupling
- Easy maintenance
- Reusability
- Independent testing

---

# Resource Naming Strategy

Resource names follow a consistent convention.

Example:

```text
project-resource-environment

mathlab-ai-alb

mathlab-ai-asg

mathlab-ai-vpc
```

Consistent naming improves discoverability and operational management.

---

# Tagging Strategy

Every AWS resource includes common tags.

Mandatory tags include:

- Project
- Environment
- ManagedBy
- Owner
- Name

Tags support:

- Cost allocation
- Governance
- Inventory
- Automation

---

# Monitoring Strategy

Amazon CloudWatch collects infrastructure metrics including:

- CPU Utilization
- Network Throughput
- Instance Health
- Auto Scaling Activity

These metrics provide operational visibility into the deployed infrastructure.

---

# Disaster Recovery

The infrastructure supports rapid recovery through:

- Infrastructure as Code
- Immutable deployments
- Version-controlled configuration
- Terraform state management
- Automated resource recreation

Recovery involves reapplying the Terraform configuration instead of manually rebuilding infrastructure.

---

# Design Principles

This project was designed according to the following engineering principles:

- Infrastructure as Code
- Security by Default
- Least Privilege
- High Availability
- Scalability
- Automation
- Modularity
- Maintainability
- Reproducibility
- Documentation First

---

# Conclusion

The MathLab AI Infrastructure provides a production-oriented AWS environment built using Terraform. Its modular design, layered architecture, strong security posture, and comprehensive documentation make it suitable for enterprise-style cloud deployments while serving as a practical demonstration of Infrastructure as Code principles.
