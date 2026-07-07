# Architecture Decisions

This document records important architectural decisions made during the project.

---

# ADR-001

## Title

Use a Modular Terraform Architecture

### Status

Accepted

### Decision

Terraform will be organised into reusable modules.

### Rationale

- Reusability
- Maintainability
- Easier testing
- Better separation of concerns

---

# ADR-002

## Title

Deploy Across Two Availability Zones

### Status

Accepted

### Decision

Deploy all highly available resources across two Availability Zones.

### Rationale

- High Availability
- Fault Tolerance
- AWS Best Practices

---

# ADR-003

## Title

Use Public and Private Subnets

### Status

Accepted

### Decision

Deploy the Application Load Balancer in public subnets and EC2 instances in private subnets.

### Rationale

- Improved security
- Reduced attack surface
- AWS recommended architecture

---

# ADR-004

## Title

Use a Single NAT Gateway

### Status

Accepted

### Decision

Deploy one NAT Gateway.

### Rationale

For this workload, a single NAT Gateway provides outbound internet connectivity for private EC2 instances while significantly reducing monthly cost compared to deploying one NAT Gateway per Availability Zone.

This is an intentional balance between Cost Optimization and Reliability within the AWS Well-Architected Framework.

---

# ADR-005

## Title

No Public SSH Access

### Status

Accepted

### Decision

Do not expose TCP port 22 to the internet.

### Rationale

- Principle of Least Privilege
- Reduced attack surface
- Production security best practice

Future administrative access can be implemented using AWS Systems Manager Session Manager if required.

---

# ADR-006

## Title

Use Dedicated Security Groups

### Status

Accepted

### Decision

Use separate security groups for the Application Load Balancer and EC2 instances.

### Rationale

This allows traffic to flow only from the ALB to the EC2 instances and prevents direct public access to the application servers.
