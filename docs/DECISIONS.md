# Architectural Decisions

## Overview

This document records the major architectural decisions made during the design and implementation of the MathLab AI Infrastructure project.

Each decision explains:

- The problem being solved
- The availoable alternatives
- The selected solution
- The rationale
- The consequences

Recording architectural decisions improves maintainability, supports future enhancements, and provides context for engineering and operational teams.

---

# ADR-001

## Decision

Use Infrastructure as Code (IaC) with Terraform.

### Status

Accepted

### Context

The project requires a repeatable, maintainable, and automated method for provisioning AWS infrastructure.

Manual provisioning through the AWS Management Console is error-prone, difficult to audit, and cannot easily be reproduced.

### Alternatives Considered

- AWS Management Console
- AWS CloudFormation
- Pulumi
- Terraform

### Decision

Terraform was selected.

### Rationale

- Cloud agnostic
- Large AWS provider ecosystem
- Excellent module support
- Version controlled
- Declarative infrastructure
- Strong community support

### Consequences

Infrastructure becomes reproducible, auditable, modular, and easier to maintain.

---

# ADR-002

## Decision

Use a modular Terraform architecture

### Status

Accepted

### Context

As infrastructure grows, maintaining a single Terraform configuration becomes increasingly difficult.

### Alternatives Considered

- Monolithic configuration
- Multiple workspaces
- Modular architecture

### Decision

Separate every AWS service into its own reusable module.

### Rationale

Improves:

- Code reuse
- Testing
- Maintenance
- Scalability
- Team collaboration

### Consequences

Slightly more files but significantly improved maintainability.

---

# ADR-003

## Decision

Deploy resources inside a dedicated Amazon VPC.

### Status

Accepted

### Context

AWS resources require network isolation.

### Decision

Provision a dedicated VPC with public and private subnets.

### Rationale

Provides:

- Isolation
- Security
- Controlled routing
- Multi-tier architecture

### Consequences

Improved security and future extensibility.

---

# ADR-004

## Decision

Use Public and Private Subnets.

### Status

Accepted

### Context

Application servers should not be directly accessible from the Internet.

### Decision

Deploy:

- Public subnets
- Private subnets

### Rationale

Only the Application Load Balancer is publicly accessible.

EC2 instances remain private.

### Consequences

Reduces attack surface.

---

# ADR-005

## Decision

Use an Application Load Balancer.

### Status

Accepted

### Context

Traffic must be distributed across multiple EC2 instances.

### Alternatives

- Classic Load Balancer
- Network Load Balancer
- Application Load Balancer

### Decision

Application Load Balancer.

### Rationale

Supports:

- HTTP
- HTTPS
- Health checks
- Target Groups
- Layer 7 routing

### Consequences

Improved scalability and availability.

---

# ADR-006

## Decision

Use an Auto Scaling Group.

### Status

Accepted

### Context

Infrastructure should automatically recover from failure and adapt to changes in demand.

### Decision

Deploy EC2 instances using Auto Scaling.

### Rationale

Provides:

- Self-healing
- Horizontal scaling
- Automatic replacement

### Consequences

Higher availability with reduced operational effort.

---

# ADR-007

## Decision

Use Launch Templates.

### Status

Accepted

### Context

All EC2 instances must be deployed with identical configurations.

### Decision

Use an EC2 Launch Template.

### Rationale

Centralises:

- IAM
- User data
- IAM profile
- Security Groups
- Monitoring
- Metadata options

### Consequences

Consistent deployments.

---

# ADR-008

## Decision

Use Amazon S3 for deployment artifacts.

### Status

Accepted

### Context

Website files require durable storage accessible by EC2 instances.

### Decision

Store deployment packages in Amazon S3.

### Rationale

Provides:

- High durability
- Versioning
- Encryption
- Lifecycle policies

### Consequences

Centralised artifact management.

---

# ADR-009

## Decision

Use Amazon CloudFront.

## Status

Accepted

### Context

Users should recieve low-latency content worldwide.

### Decision

Deploy Amazon CloudFront

### Rationale

Provides:

- Global edge network
- HTTPS
- Static asset caching
- Reduced origin load

### Consequences

Improved performance and reduced latency.

---

# ADR-010

## Decision

Protect the S3 bucket using Origin Access Control.

## Status

Accepted

### Context

Static assets should never be publicly accessible.

### Decision

Use CloudFront Origin Access Control (OAC).

### Rationale

Only CloudFront can retrieve S3 objects.

## Consequences

Improved security.

---

# ADR-011

## Decision

Use AWS Certificate Manager.

### Status

Accepted

### Context

All public traffic should be encrypted.

### Decision

Issue TLS certificates using ACM.

### Rationale

- Free certificates
- Automatic renewal
- Native AWS integration

### Consequences

Secure HTTPS communications.

---

# ADR-012

## Decision

Use Amazon Route 53.

## Status

Accepted

### Context

The project specification requires Route 53 for DNS management.

### Decision

Create Route 53 Hosted Zones and Alias Records using Terraform.

### Rationale

- Native AWS integration
- Alias support
- Infrastructure as Code
- Automated management

### Consequences

DNS configuration becomes version-controlled and reproducible.

---

# ADR-013

## Decision

Implement Least Privilege IAM.

### Status

Accepted

### Context

EC2 instances require limited AWS permissions.

### Decision

Grant only the permissions required for the workload.

### Rationale

Reduces security risk.

### Consequences

Smaller attack surface

---

# ADR-014

## Decision

Enable encryption by default.

### Status

Accpted

### Context

Sensitive infrastructure resources should be protected.

### Decision

Enable:

- S3 Server-Side Encryption
- Encrypted EBS volumes

### Rationale

Protects data at rest.

### Consequences

Improved compliance and security.

---

# ADR-015

## Decision

Adopt comprehensive documentation.

### Status

Accepted

### Context

Infrastructure projects often fail du to insufficient documentation.

### Decision

Produce dedicated documentation covering:

- Architecture
- Deployment
- Security
- Operations
- Testing
- Troubleshooting
- Cost Estimation
- Design Decisions

### Rationale

Supports long-term maintenance and knowledge transfer.

### Consequences

Improved maintainability and onboarding.

---

# Conclusion

The architectural decisions documented here reflect a deliberate emphasis on security, scalability, maintainability, and automation. Each decision aligns with AWS best practices, Infrastructure as Code principles, and the project's objective of delivering a production-quality cloud infrastructure suitable for real-world engineering practices.
