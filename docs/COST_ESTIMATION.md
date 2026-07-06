# Cost Estimation

This document provides an estimated monthly cost for the AWS infrastructure used in this project.

The estimates are intended for planning purposes only. Actual costs depend on AWS Region, service usage, traffic volume, storage consumption, scaling activity, and AWS pricing at the time of deployment.

AWS pricing changes periodically. Always verify current pricing using the AWS Pricing Calculator before deploying to production.

---

# Cost Estimation Objectives

This document aims to:

- Estimate the monthly infrastructure cost.
- Identify the major cost contributors.
- Promote cost-aware architectural decisions.
- Support the AWS Well-Architected Cost Optimization Pillar.

---

# Assumptions

The following assumptions are used for this estimate.

- One production environment.
- Moderate website traffic.
- Static HTML, CSS, and JavaScript website.
- Auto Scaling enabled.
- Multiple Availability Zones.
- Infrastructure deployed continuously for one month.

Actual usage may increase or decrease the total monthly cost.

---

# Estimated AWS Services

The project uses the following AWS services.

| AWS Service               | Purpose                                 |
| ------------------------- | --------------------------------------- |
| Amazon VPC                | Network isolation                       |
| Internet Gateway          | Internet connectivity                   |
| Security Groups           | Network security                        |
| IAM                       | Identity and access management          |
| Amazon EC2                | Website hosting                         |
| Auto Scaling              | Automatic scaling                       |
| Application Load Balancer | Traffic distribution                    |
| Amazon S3                 | Static asset storage (where applicable) |
| Amazon CloudFront         | Global content delivery                 |
| Amazon Route 53           | DNS management                          |
| Amazon CloudWatch         | Monitoring and logging                  |

---

# Estimated Monthly Costs

| Service                   | Estimated Monthly Cost                          |
| ------------------------- | ----------------------------------------------- |
| Amazon EC2                | Varies by instance type and usage               |
| Application Load Balancer | Varies by traffic volume                        |
| Amazon CloudFront         | Varies by requests and data transfer            |
| Amazon S3                 | Varies by storage and requests                  |
| Amazon Route 53           | Varies by hosted zones and DNS queries          |
| Amazon CloudWatch         | Varies by metrics, dashboards, alarms, and logs |
| Data Transfer             | Varies by outbound traffic                      |

The final cost depends on the workload and AWS pricing at the time of deployment.

---

# Primary Cost Drivers

The largest contributors to infrastructure cost are expected to be:

- Amazon EC2
- Application Load Balancer
- Amazon CloudFront
- Data transfer
- CloudWatch logging

These services should be monitored regularly to avoid unexpected costs.

---

# Cost Optimization Strategy

The infrastructure follows AWS Cost Optimization best practices.

## Infrastructure as Code

Terraform enables:

- Consistent deployments.
- Resource tracking.
- Easier cleanup.
- Reduced orphaned resources.

---

## Auto Scaling

Auto Scaling helps reduce unnecessary costs by:

- Launching instances only when required.
- Terminating excess capacity automatically.
- Matching infrastructure capacity to demand.

---

## CloudFront

CloudFront reduces origin load by:

- Caching static content.
- Serving requests from edge locations.
- Reducing requests to EC2 instances.

---

## Amazon S3

Where appropriate, S3 provides cost-effective storage for static assets and other supporting resources.

Lifecycle management may be implemented if it provides measurable operational or financial benefit.

---

## Monitoring

CloudWatch provides visibility into resource utilization.

Monitoring helps identify:

- Underutilized resources.
- Unnecessary infrastructure.
- Scaling opportunities.
- Operational inefficiencies.

---

# Cost Monitoring

Infrastructure costs should be reviewed regularly using AWS billing and monitoring services.

Recommended practices include:

- Review monthly AWS costs.
- Monitor resource utilization.
- Remove unused resources.
- Destroy non-production infrastructure when no longer required.
- Review CloudWatch metrics before increasing capacity.

---

# Future Cost Updates

As additional AWS resources are implemented, this document will be updated to include:

- Networking considerations.
- EC2 instance selection rationale.
- Auto Scaling impact.
- CloudFront usage patterns.
- Monitoring costs.
- DNS costs.
- Production deployment estimates.

---

# Cost Optimization Checklist

Before production deployment, verify:

- Infrastructure uses only required AWS resources.
- Auto Scaling is configured appropriately.
- CloudFront caching is optimized.
- Unused resources have been removed.
- Monitoring is appropriately configured.
- Infrastructure follows AWS Cost Optimization best practices.

---

# AWS Well-Architected Alignment

This project supports the Cost Optimization pillar through:

- Infrastructure as Code.
- Automated scaling.
- Managed AWS services.
- Infrastructure lifecycle management.
- Continuous monitoring.
- Resource optimization.

---

# Revision History

| Version | Description                               |
| ------- | ----------------------------------------- |
| 0.1.0   | Initial cost estimation document created. |
