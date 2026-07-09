# CloudWatch Module

## Overview

The CloudWatch module provisions monitoring resources for the MathLab AI Infrastructure.

It enables operational visibility into the application's infrastructure by collecting metrics, monitoring resource health, and generating alerts when predefined thresholds are exceeded.

The module integrates with Amazon EC2, Auto Scaling Groups, Application Load Balancers, and other AWS services to support proactive monitoring and operational excellence.

---

# Features

- Creates CloudWatch Alarms
- Monitors EC2 instances
- Monitors Auto Scaling Groups
- Monitors Application Load Balancer
- Supports Amazon SNS notifications
- Enables operational monitoring
- Supports future dashboard integration
- Applies consistent resource tagging

---

# Resources Created

| Resource           | Purpose                    |
| ------------------ | -------------------------- |
| CloudWatch Alarm   | CPU utilization monitoring |
| CloudWatch Alarm   | Instance health monitoring |
| CloudWatch Alarm   | Load Balancer monitoring   |
| CloudWatch Alarm   | Auto Scaling monitoring    |
| CloudWatch Metrics | Infrastructure monitoring  |

---

# Architecture

```
                EC2 Instances
                     │
                     ▼
              CloudWatch Metrics
                     │
                     ▼
            CloudWatch Alarms
                     │
                     ▼
             Amazon SNS (Optional)
                     │
                     ▼
             Operations Team
```

CloudWatch continuously collects infrastructure metrics and evaluates alarm thresholds.

---

# Monitoring Scope

The module is designed to monitor the following AWS resources:

- Amazon EC2
- Auto Scaling Group
- Application Load Balancer
- CloudFront (future enhancement)
- Route 53 Health Checks (future enhancement)

---

# Monitored Metrics

Typical metrics include:

| Metric             | Purpose                        |
| ------------------ | ------------------------------ |
| CPUUtilization     | Detect high CPU usage          |
| StatusCheckFailed  | Detect unhealthy EC2 instances |
| NetworkIn          | Monitor inbound traffic        |
| NetworkOut         | Monitor outbound traffic       |
| RequestCount       | Monitor ALB traffic            |
| HealthyHostCount   | Verify backend health          |
| UnHealthyHostCount | Detect failed instances        |

---

# Alarm Workflow

```
Infrastructure Metric
          │
          ▼
CloudWatch evaluates threshold
          │
          ▼
Threshold exceeded?
     │
 ┌───┴────┐
 │        │
No       Yes
 │        │
 ▼        ▼
Continue  Alarm State
           │
           ▼
      Notification
```

This workflow enables rapid detection of operational issues.

---

# Alarm States

CloudWatch alarms operate in three states:

| State             | Meaning                                    |
| ----------------- | ------------------------------------------ |
| OK                | Resource operating normally                |
| ALARM             | Threshold exceeded                         |
| INSUFFICIENT_DATA | CloudWatch requires additional metric data |

---

# Inputs

| Name                   | Description                   | Type        | Required |
| ---------------------- | ----------------------------- | ----------- | -------- |
| project_name           | Project name                  | string      | Yes      |
| environment            | Deployment environment        | string      | Yes      |
| autoscaling_group_name | Auto Scaling Group name       | string      | Yes      |
| load_balancer_arn      | Application Load Balancer ARN | string      | Yes      |
| target_group_arn       | Target Group ARN              | string      | Yes      |
| notification_topic_arn | SNS Topic ARN                 | string      | No       |
| tags                   | Common resource tags          | map(string) | Yes      |

---

# Outputs

| Output                 | Description         |
| ---------------------- | ------------------- |
| cpu_alarm_name         | CPU Alarm name      |
| alb_alarm_name         | Load Balancer alarm |
| autoscaling_alarm_name | Auto Scaling alarm  |

---

# Dependencies

This module depends on:

- Application Load Balancer Module
- Auto Scaling Module

Optional integration:

- Amazon SNS

---

# Example Usage

```hcl
module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name = var.project_name

  environment = var.environment

  autoscaling_group_name = module.autoscaling.autoscaling_group_name

  load_balancer_arn = module.alb.alb_arn

  target_group_arn = module.alb.target_group_arn

  tags = local.common_tags
}
```

---

# Alerting

CloudWatch alarms can be configured to notify administrators using Amazon SNS.

Possible notification channels include:

- Email
- SMS
- AWS Chatbot
- Slack
- Incident Management Systems

For this university project, SNS integration is optional but supported by the architecture.

---

# Security

The CloudWatch module contributes to operational security by:

- Detecting abnormal infrastructure behavior
- Monitoring failed health checks
- Identifying unexpected traffic spikes
- Supporting rapid incident response
- Providing centralized monitoring

Monitoring does not directly secure infrastructure but significantly improves operational awareness.

---

# Operational Notes

CloudWatch metrics are collected automatically by AWS for supported services.

After deployment:

1. Metrics are published.
2. CloudWatch evaluates alarm thresholds.
3. Alarm state changes when thresholds are exceeded.
4. Optional notifications are sent through Amazon SNS.

---

# Maintenance

When updating this module:

- Review alarm thresholds.
- Validate monitored resources.
- Confirm SNS configuration (if used).
- Execute `terraform validate`.
- Review the Terraform execution plan before deployment.

---

# Future Enhancements

Potential improvements include:

- CloudWatch Dashboards
- CloudWatch Logs
- CloudWatch Log Insights
- Custom Metrics
- Contributor Insights
- Composite Alarms
- Anomaly Detection
- CloudWatch Synthetics
- CloudWatch RUM
- AWS X-Ray integration

These features provide deeper operational visibility and support enterprise-scale monitoring.

---

# Troubleshooting

## Alarm remains in INSUFFICIENT_DATA

Verify:

- The monitored resource is running.
- Metrics are being published.
- Alarm dimensions are correct.

---

## Alarm never triggers

Check:

- Threshold values.
- Evaluation periods.
- Metric namespace.
- Resource identifiers.

---

## Missing metrics

Ensure:

- EC2 instances are running.
- Load Balancer is receiving traffic.
- Auto Scaling Group has active instances.

---

# Best Practices

This module follows AWS Well-Architected Framework recommendations by:

- Monitoring critical infrastructure
- Supporting proactive operations
- Encouraging automated alerting
- Enabling operational excellence
- Reducing mean time to detection (MTTD)

---

# Conclusion

The CloudWatch module provides comprehensive monitoring capabilities for the MathLab AI Infrastructure. By continuously collecting metrics, evaluating resource health, and generating operational alerts, it enhances reliability, supports rapid incident response, and aligns the infrastructure with AWS production best practices.
