# Architecture Decision Records (ADRs)

This document records the significant architectural decisions made throughout the project.

Each decision includes the context, the decision itself, and the rationale behind it. Recording these decisions ensures that future engineers understand why specific technologies and architectural patterns were selected.

Additional Architecture Decision Records (ADRs) will be added as the project progresses.

---

# ADR-001: Infrastructure as Code

## Status

Accepted

## Context

The project requires a repeatable, maintainable, and version-controlled method of provisioning AWS infrastructure.

Manual provisioning is error-prone, difficult to reproduce, and unsuitable for production environments.

## Decision

Use Terraform as the Infrastructure as Code (IaC) tool for provisioning all supported AWS resources.

## Rationale

Terraform provides:

- Declarative infrastructure definitions.
- Modular architecture.
- Version control integration.
- Repeatable deployments.
- Multi-cloud support.
- Large community support.
- Mature AWS provider.

## Consequences

### Positive

- Infrastructure is reproducible.
- Reduced configuration drift.
- Easier collaboration.
- Version-controlled infrastructure.
- Easier disaster recovery.

### Negative

- Requires Terraform knowledge.
- Requires state management.

---

# ADR-002: Static Website Architecture

## Status

Accepted

## Context

The workload consists of HTML, CSS, and JavaScript website.

The assessment focuses on cloud infrastructure rather than web application development.

## Decision

Deploy the website without modifying its source code.

The website will be served by Nginx running on Amazon EC2 instances.

## Rationale

This approach:

- Meets project requirements.
- Separates infrastructure from application code.
- Simplifies maintenance.
- Supports future website updates.

## Consequences

### Positive

- Minimal application changes.
- Straightforward deployment.
- Production-ready hosting.

### Negative

- Dynamic server-side functionality is outside the project scope.

---

# ADR-003: High Availability

## Status

Accepted

## Context

Production workloads should remain available during infrastructure failures.

## Decision

Deploy EC2 instances across multiple Availability Zones using an Auto Scaling Group behind an Application Load Balancer.

## Rationale

This architecture improves:

- Availability.
- Fault tolerance.
- Scalability.
- Reliability.

## Consequences

### Positive

- Automatic recovery.
- Traffic distribution.
- Improved resilience.

### Negative

- Increased infrastructure complexity.
- Additional AWS costs.

---

# ADR-004: Content Delivery Network

## Status

Accepted

## Context

Users may access the website from different geographic locations.

## Decision

Use Amazon CloudFront as the Content Delivery Network (CDN).

## Rationale

CloudFront provides:

- Lower latency.
- Edge caching.
- Improved performance.
- HTTPS support.
- Global distribution.

## Consequences

### Positive

- Faster website delivery.
- Reduced origin load.
- Improved user experience.

### Negative

- Additional service configuration.
- Cache management considerations.

---

# ADR-005: Infrastructure Security

## Status

Accepted

## Context

Infrastructure must follow AWS security best practices.

## Decision

Apply the Principle of Least Privilege and secure-by-default configurations throughout the infrastructure.

## Rationale

Security controls reduce the attack surface and protect AWS resources.

## Consequences

### Positive

- Reduced security risk.
- Improved compliance.
- Better operational security.

### Negative

- Additional configuration effort.

---

# ADR-006: Infrastructure Documentation

## Status

Accepted

## Context

The repository should be understandable by another engineer without requiring additional explanation.

## Decision

Maintain documentation throughout the project rather than documenting only after implementation.

## Rationale

Incremental documentation:

- Improves maintainability.
- Supports knowledge transfer.
- Simplifies future updates.
- Provides an accurate representation of the infrastructure.

## Consequences

### Positive

- Documentation remains synchronized with implementation.
- Easier project handover.
- Better maintainability.

### Negative

- Requires documentation updates after every milestone.

---

# Future Architecture Decisions

Additional ADRs will be added as the project progresses.

Planned topics include:

- VPC design.
- CIDR allocation strategy.
- Security Group architecture.
- IAM design.
- S3 configuration.
- CloudFront configuration.
- Launch Template design.
- Auto Scaling policies.
- CloudWatch monitoring.
- Route 53 DNS configuration.
- Production hardening decisions.

---

# Decision Summary

| ADR     | Decision                             | Status   |
| ------- | ------------------------------------ | -------- |
| ADR-001 | Terraform for Infrastructure as Code | Accepted |
| ADR-002 | Deploy existing static website       | Accepted |
| ADR-003 | High Availability architecture       | Accepted |
| ADR-004 | Amazon CloudFront CDN                | Accepted |
| ADR-005 | Secure-by-default infrastructure     | Accepted |
| ADR-006 | Incremental project documentation    | Accepted |

---

# Revision History

| Version | Description                                    |
| ------- | ---------------------------------------------- |
| 0.1.0   | Initial Architecture Decision Records created. |
