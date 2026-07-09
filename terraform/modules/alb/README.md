# Application Load Balancer Module

## Overview

The Application Load Balancer (ALB) module provisions an internet-facing AWS Application Load Balancer that distributes incoming HTTP traffic across EC2 instances running in private subnets.

The load balancer improves availability, scalability, and fault tolerance by routing requests only to healthy instances registered in the Target Group.

This module serves as the primary origin for the CloudFront distribution.

---

# Features

- Creates an internet-facing Application Load Balancer
- Creates an HTTP Target Group
- Configures health checks
- Creates an HTTP Listener
- Supports Auto Scaling integration
- Distributes traffic across multiple Availability Zones
- Applies consistent resource tagging

---

# Resources Created

| Resource                  | Purpose                            |
| ------------------------- | ---------------------------------- |
| Application Load Balancer | Receives client requests           |
| Target Group              | Registers EC2 instances            |
| HTTP Listener             | Listens for incoming HTTP requests |
| Health Check              | Monitors application availability  |

---

# Architecture

```
                 Internet
                     │
                     ▼
              CloudFront CDN
                     │
                     ▼
      Application Load Balancer
                     │
         ┌───────────┴───────────┐
         ▼                       ▼
     EC2 Instance A         EC2 Instance B
         │                       │
         └───────────┬───────────┘
                     ▼
            Auto Scaling Group
```

The Application Load Balancer automatically distributes requests to healthy EC2 instances.

---

# Health Checks

The Target Group continuously monitors registered instances.

| Setting             | Value      |
| ------------------- | ---------- |
| Protocol            | HTTP       |
| Path                | /          |
| Healthy Threshold   | 3          |
| Unhealthy Threshold | 3          |
| Interval            | 30 seconds |
| Timeout             | 5 seconds  |
| Expected Response   | HTTP 200   |

If an instance becomes unhealthy, the ALB automatically stops routing traffic to it until it recovers.

---

# Traffic Flow

Incoming requests follow this path:

```
Client
   │
   ▼
CloudFront
   │
   ▼
Application Load Balancer
   │
   ▼
Target Group
   │
   ▼
Healthy EC2 Instance
```

This architecture provides high availability and fault tolerance.

---

# Inputs

| Name              | Description                           | Type         | Required |
| ----------------- | ------------------------------------- | ------------ | -------- |
| project_name      | Project name used for resource naming | string       | Yes      |
| environment       | Deployment environment                | string       | Yes      |
| vpc_id            | VPC ID                                | string       | Yes      |
| public_subnet_ids | Public subnet IDs                     | list(string) | Yes      |
| security_group_id | ALB Security Group ID                 | string       | Yes      |
| tags              | Common resource tags                  | map(string)  | Yes      |

---

# Outputs

| Output           | Description                   |
| ---------------- | ----------------------------- |
| alb_id           | Application Load Balancer ID  |
| alb_arn          | Application Load Balancer ARN |
| alb_dns_name     | DNS name                      |
| alb_zone_id      | Hosted Zone ID                |
| target_group_arn | Target Group ARN              |

---

# Dependencies

This module depends on:

- Networking Module
- Security Group Module

Required inputs:

- VPC ID
- Public Subnet IDs
- ALB Security Group ID

Modules depending on this module include:

- Auto Scaling
- CloudFront
- Route 53

---

# Example Usage

```hcl
module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  security_group_id  = module.security_groups.alb_security_group_id

  tags = local.common_tags
}
```

---

# High Availability

The Application Load Balancer is deployed across two public subnets located in separate Availability Zones.

Benefits include:

- Increased fault tolerance
- Improved application availability
- Automatic traffic distribution
- Support for Auto Scaling
- No single point of failure

---

# Security

The ALB is protected using a dedicated Security Group.

Allowed inbound traffic:

| Port | Source   |
| ---- | -------- |
| 80   | Internet |
| 443  | Internet |

Traffic forwarded to EC2 instances is restricted to the EC2 Security Group.

Direct client access to EC2 instances is not permitted.

---

# Monitoring

The ALB integrates with Amazon CloudWatch to expose operational metrics including:

- Request Count
- Target Response Time
- HTTP 4XX Errors
- HTTP 5XX Errors
- Healthy Host Count
- Unhealthy Host Count
- Processed Bytes
- Active Connections

These metrics can be used to create alarms and dashboards.

---

# Maintenance

Before deployment:

- Validate Target Group configuration.
- Verify health check settings.
- Confirm subnet assignments.
- Review Security Group rules.
- Execute `terraform validate`.
- Review the Terraform execution plan.

---

# Best Practices

This module follows AWS Well-Architected Framework recommendations by:

- Deploying across multiple Availability Zones
- Performing continuous health checks
- Using dedicated Security Groups
- Separating compute from networking
- Supporting Auto Scaling
- Applying Infrastructure as Code
- Using consistent tagging

---

# Conclusion

The Application Load Balancer module provides a scalable, highly available, and fault-tolerant entry point for the MathLab AI application. By distributing traffic only to healthy EC2 instances and integrating with Auto Scaling and CloudFront, it forms a critical component of the production-ready architecture.
