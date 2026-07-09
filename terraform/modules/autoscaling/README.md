# Auto Scaling Module

## Overview

The Auto Scaling module provisions an Amazon EC2 Auto Scaling Group (ASG) that automatically manages the lifecycle of the application's web server instances.

The module ensures that the desired number of EC2 instances is always maintained, automatically replaces unhealthy instances, and integrates with the Application Load Balancer to distribute traffic only to healthy servers.

Combined with the Launch Template, this module provides a resilient, fault-tolerant, and production-ready compute platform.

---

# Features

- Creates an Amazon EC2 Auto Scaling Group
- Integrates with the Launch Template
- Deploys instances across multiple Availability Zones
- Registers instances with the Application Load Balancer
- Automatically replaces unhealthy instances
- Supports automatic horizontal scaling
- Publishes Auto Scaling metrics to Amazon CloudWatch
- Applies consistent resource tagging

---

# Resources Created

| Resource           | Purpose                                     |
| ------------------ | ------------------------------------------- |
| Auto Scaling Group | Manages EC2 instance lifecycle              |
| Scale-Out Policy   | Adds EC2 instances during increased demand  |
| Scale-In Policy    | Removes EC2 instances during reduced demand |

---

# Architecture

```
                    CloudFront
                         │
                         ▼
          Application Load Balancer
                         │
                         ▼
                Target Group (HTTP)
                         │
        ┌────────────────┴────────────────┐
        ▼                                 ▼
  EC2 Instance                     EC2 Instance
        ▲                                 ▲
        └──────────────┬──────────────────┘
                       │
               Auto Scaling Group
                       │
                       ▼
               Launch Template
```

The Auto Scaling Group continuously monitors the health of EC2 instances and ensures the desired capacity is maintained.

---

# Scaling Configuration

The module is configured with the following default capacity values:

| Setting          | Default |
| ---------------- | ------- |
| Desired Capacity | 2       |
| Minimum Capacity | 2       |
| Maximum Capacity | 4       |

This configuration provides high availability by ensuring at least two application servers are always running.

---

# Health Checks

The Auto Scaling Group uses Elastic Load Balancer (ELB) health checks.

| Setting           | Value       |
| ----------------- | ----------- |
| Health Check Type | ELB         |
| Grace Period      | 300 seconds |

The Application Load Balancer determines instance health by performing regular HTTP health checks.

If an instance becomes unhealthy:

1. The instance is marked unhealthy.
2. The Auto Scaling Group terminates it.
3. A replacement instance is launched automatically.
4. The new instance executes the bootstrap script.
5. The instance joins the Target Group after passing health checks.

No manual intervention is required.

---

# Scaling Policies

## Scale-Out Policy

The scale-out policy increases application capacity by launching one additional EC2 instance.

| Property           | Value            |
| ------------------ | ---------------- |
| Adjustment Type    | ChangeInCapacity |
| Scaling Adjustment | +1               |
| Cooldown           | 300 seconds      |

---

## Scale-In Policy

The scale-in policy reduces infrastructure costs by terminating one EC2 instance when demand decreases.

| Property           | Value            |
| ------------------ | ---------------- |
| Adjustment Type    | ChangeInCapacity |
| Scaling Adjustment | -1               |
| Cooldown           | 300 seconds      |

---

# Metrics

The Auto Scaling Group publishes the following metrics to Amazon CloudWatch:

- GroupDesiredCapacity
- GroupInServiceInstances
- GroupPendingInstances
- GroupTerminatingInstances
- GroupTotalInstances

These metrics provide operational visibility into the health and scaling behaviour of the infrastructure.

---

# Instance Lifecycle

The lifecycle of a new EC2 instance is as follows:

```
Launch Template
       │
       ▼
EC2 Instance Created
       │
       ▼
Bootstrap Script Executes
       │
       ▼
Website Installed
       │
       ▼
Health Check Passes
       │
       ▼
Added to Target Group
       │
       ▼
Receives Client Traffic
```

This process is fully automated.

---

# Inputs

| Name                           | Description                                | Type         | Required |
| ------------------------------ | ------------------------------------------ | ------------ | -------- |
| project_name                   | Project name used for naming AWS resources | string       | Yes      |
| environment                    | Deployment environment                     | string       | Yes      |
| launch_template_id             | Launch Template ID                         | string       | Yes      |
| launch_template_latest_version | Latest Launch Template version             | string       | Yes      |
| private_subnet_ids             | Private subnet IDs                         | list(string) | Yes      |
| target_group_arn               | Application Load Balancer Target Group ARN | string       | Yes      |
| desired_capacity               | Desired number of EC2 instances            | number       | No       |
| min_size                       | Minimum Auto Scaling Group size            | number       | No       |
| max_size                       | Maximum Auto Scaling Group size            | number       | No       |
| tags                           | Common resource tags                       | map(string)  | Yes      |

---

# Outputs

| Output                 | Description             |
| ---------------------- | ----------------------- |
| autoscaling_group_id   | Auto Scaling Group ID   |
| autoscaling_group_name | Auto Scaling Group name |
| autoscaling_group_arn  | Auto Scaling Group ARN  |
| scale_out_policy_arn   | Scale-Out Policy ARN    |
| scale_in_policy_arn    | Scale-In Policy ARN     |

---

# Dependencies

This module depends on:

- Launch Template Module
- Networking Module
- Application Load Balancer Module

Required inputs:

- Launch Template ID
- Launch Template Version
- Private Subnet IDs
- Target Group ARN

---

# Example Usage

```hcl
module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  launch_template_id             = module.launch_template.launch_template_id
  launch_template_latest_version = module.launch_template.launch_template_latest_version

  private_subnet_ids = module.networking.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  tags = local.common_tags
}
```

---

# High Availability

The Auto Scaling Group contributes to high availability by:

- Deploying instances across multiple Availability Zones
- Automatically replacing unhealthy instances
- Maintaining minimum capacity
- Integrating with the Application Load Balancer
- Supporting zero-downtime scaling operations

This architecture eliminates single points of failure within the compute layer.

---

# Security

The Auto Scaling Group launches instances using the secure Launch Template configuration.

Each instance includes:

- IAM Instance Profile
- Encrypted Amazon EBS storage
- IMDSv2 enabled
- Private subnet deployment
- Dedicated EC2 Security Group

No EC2 instance receives a public IP address.

---

# Maintenance

When modifying this module:

- Verify Launch Template compatibility.
- Review desired, minimum, and maximum capacities.
- Validate Target Group integration.
- Confirm health check settings.
- Execute `terraform validate`.
- Review the Terraform execution plan before deployment.

---

# Future Enhancements

Potential improvements include:

- Target Tracking Scaling Policies
- Step Scaling Policies
- Predictive Scaling
- Warm Pools
- Scheduled Scaling
- Mixed Instance Policies
- Spot Instance integration
- Instance Refresh strategies

These enhancements can further improve cost optimisation and application responsiveness in larger production environments.

---

# Conclusion

The Auto Scaling module provides automated instance lifecycle management for the MathLab AI Infrastructure. By integrating with the Launch Template and Application Load Balancer, it ensures that the application remains highly available, fault tolerant, and capable of adapting to changing workloads without manual intervention.
