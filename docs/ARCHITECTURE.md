# AWS Infrastructure Architecture

This document describes the architecture, design decisions, and infrastructure components used to host the static website on Amazon Web Services (AWS).

The architecture is designed according to AWS Well-Architected Framework principles and follows Infrastructure as Code (IaC) practices using Terraform.

---

# Architecture Goals

The infrastructure is designed to achieve the following goals:

- High Availability
- Fault Tolerance
- Scalability
- Security
- Low Latency
- Infrastructure as Code
- Production Readiness
- Maintainability
- Reproducibility

---

# High-Level Architecture

![AWS-Architecture](../Highly%20Available%20Auto-Scaling%20AWS%20Web%20Hosting%20Architecture.png)

---

# Infrastructure Components

## Amazon Route 53

Route 53 provides DNS services for the application.

Responsibilities include:

- Domain resolution
- Alias records
- Routing traffic to CloudFront
- Highly available DNS

---

## Amazon CloudFront

CloudFront acts as the global Content Delivery Network (CDN).

Responsibilities include:

- Global edge caching
- HTTPS termination
- Reduced latency
- Static content acceleration
- Improved website performance

---

## Application Load Balancer

The Application Load Balancer distributes incoming traffic across multiple EC2 instances.

Responsibilities include:

- Layer 7 load balancing
- Health checks
- Traffic distribution
- High availability

---

## Auto Scaling Group

The Auto Scaling Group ensures application availability.

Responsibilities include:

- Automatic instance replacement
- Horizontal scaling
- Multi-AZ deployment
- Desired capacity management

---

## Amazon EC2

Amazon EC2 hosts the website.

Each instance automatically:

- Launches Ubuntu Server
- Installs Nginx
- Deploys the website
- Starts required services

No manual configuration is required after provisioning.

---

## Amazon S3

Amazon S3 is used for supporting infrastructure where appropriate.

Potential responsibilities include:

- Static assets
- CloudFront origin
- Terraform backend (future enhancement)
- Log storage

---

## Amazon CloudWatch

CloudWatch provides monitoring and observability.

Responsibilities include:

- Metrics
- Alarms
- Dashboards
- Log collection
- Infrastructure monitoring

---

## AWS IAM

AWS Identity and Access Management secures access to AWS resources.

Responsibilities include:

- Least privilege access
- IAM roles
- IAM policies
- EC2 instance profiles

---

## Amazon VPC

The Virtual Private Cloud provides network isolation.

Responsibilities include:

- Secure networking
- Subnet segmentation
- Internet connectivity
- Routing
- Security boundaries

---

# Request Flow

A typical user request follows the sequence below:

1. A user enters the website URL.
2. Route 53 resolves the domain.
3. CloudFront receives the request.
4. CloudFront serves cached content when available.
5. If content is not cached, CloudFront forwards the request to the Application Load Balancer.
6. The Application Load Balancer forwards the request to a healthy EC2 instance.
7. Nginx serves the website content.
8. The response is returned through CloudFront to the user.

---

# Availability Strategy

High availability is achieved through:

- Multiple Availability Zones
- Auto Scaling Group
- Application Load Balancer
- CloudFront global edge network
- Health checks
- Automatic instance replacement

---

# Scalability Strategy

The infrastructure supports horizontal scaling.

When demand increases:

- CloudWatch detects increased resource utilization.
- Auto Scaling launches additional EC2 instances.
- The Application Load Balancer automatically distributes traffic.

When demand decreases:

- Auto Scaling safely terminates excess instances.

---

# Security Strategy

Security principles include:

- Principle of Least Privilege
- Restricted Security Groups
- IAM Roles instead of long-lived credentials
- Encryption where supported
- HTTPS
- Controlled public exposure
- Infrastructure as Code

Detailed security controls are documented in `SECURITY.md`.

---

# Infrastructure as Code

All infrastructure resources are provisioned using Terraform.

Terraform provides:

- Repeatable deployments
- Version control
- Modular design
- Reusable infrastructure
- Reduced configuration drift

No manual infrastructure provisioning is required unless explicitly required by AWS.

---

# AWS Well-Architected Framework Alignment

| Pillar                 | Implementation                                         |
| ---------------------- | ------------------------------------------------------ |
| Operational Excellence | Infrastructure as Code, documentation, version control |
| Security               | IAM, Security Groups, least privilege, encryption      |
| Reliability            | Multi-AZ deployment, Auto Scaling, health checks       |
| Performance Efficiency | CloudFront, Load Balancer, Auto Scaling                |
| Cost Optimization      | Elastic scaling, managed AWS services                  |
| Sustainability         | Automatic scaling to reduce unnecessary resource usage |

---

# Architecture Evolution

This document will be expanded as the project progresses.

Future milestones will add:

- Detailed VPC topology
- Network diagrams
- Security architecture
- Auto Scaling diagrams
- CloudFront configuration
- IAM architecture
- Monitoring architecture
- Route 53 configuration
- Deployment workflow
- Disaster recovery considerations

---

# Current Status

| Component            | Status         |
| -------------------- | -------------- |
| Repository           | ✅ Complete    |
| Documentation        | 🟡 In Progress |
| Terraform Bootstrap  | ⏳ Pending     |
| Networking           | ⏳ Pending     |
| IAM                  | ⏳ Pending     |
| S3                   | ⏳ Pending     |
| CloudFront           | ⏳ Pending     |
| EC2                  | ⏳ Pending     |
| Auto Scaling         | ⏳ Pending     |
| CloudWatch           | ⏳ Pending     |
| Route 53             | ⏳ Pending     |
| Production Hardening | ⏳ Pending     |
