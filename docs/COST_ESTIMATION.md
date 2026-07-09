# Cost Estimation

## Overview

This document provides an overview of the expected operational costs associated with the MathLab AI Infrastructure deployed on Amazon Web Services (AWS).

The infrastructure has been designed to balance security, scalability, and high availability while remaining cost-conscious for a university project.

Actual costs will vary depending on:

- Deployment duration
- Traffic volume
- Number of EC2 instances
- Data transfer
- Geographic location
- AWS pricing changes

The estimates in this document are intended for planning purposes only.

---

# Infrastructure Components

The following AWS services are provisioned by this project.

![AWS Services Snapshot](../images/AWS%20Services.png)

---

# Major Cost Drivers

The following resources contribute the majority of operational costs.

## Amazon EC2

Compute charges depend on:

- Instance type
- Number of running instances
- Operating hours

Auto Scaling can increase or decrease the number of instances based on demand.

---

## NAT Gateway

The NAT Gateway is one of the most significant recurring costs.

Charges include:

- Hourly usage
- Data processed

Since the project uses private subnets, a NAT Gateway is required for outbound Internet connectivity (for example, software updates and package installation).

---

## Application Load Balancer

Costs are based on:

- Running hours
- Load Balancer Capacity Units (LCUs)

---

CloudFront

Pricing depends on:

- Data transffered
- HTTP/HTTPS requests
- Geographic distribution of users

CloudFront can also reduce origin traffic, lowering EC2 and ALB utilization.

---

## Route 53

Charges include:

- Public Hosted Zone
- DNS queries

The cost remains relatively low for projects with modest traffic.

---

## Amazon S3

Storage costs depend on:

- Total storage used
- Number of requests
- Data transfer

Because website assets are relatively small, storage costs are expected to remain minimal.

---

## CloudWatch

Charges may apply for:

- Custom metrics
- Alarms
- Log storage
- Log ingestion

Basic monitoring provided by AWS is available at no additional cost.

---

# Free Tier Eligibility

Several services used in this project are covered, either fully or partially, by the AWS Free Tier (subject to AWS eligibility rules).

Examples include:

- Amazon VPC
- IAM
- Security Groups
- Launch Templates
- ACM
- Limited EC2 usage
- Limited S3 usage
- Limited CloudWatch usage

Always verify current Free Tier limits before deployment.

---

# Estimated Monthly Cost

The following table provides a qualitative estimate rather than fixed pricing.

![AWS Cost Expectation](../images/AWS%20Cost%20Expectation.png)

The NAT Gateway and Application Load Balancer are expected to represent the largest proportion of infrastructure costs.

---

# Cost Optimisation Strategies

The following practices have been adopted to reduce operational expenses.

## Auto Scaling

Compute capacity automatically adjusts to demand.

Benefits include:

- Reduced idle resources
- Lower compute costs

---

## CloudFront Caching

CloudFront caches static content closer to end users.

Benefits include:

- Reduced EC2 workload
- Reduced ALB requests
- Lower latency

---

## Amazon S3 Lifecycle Policies

Lifecycle rules automatically clean up incomplete multipart uploads.

Benefits include:

- Reduced storage waste
- Lower operational costs

---

## Versioned Infrastructure

Terraform allows infrastructure to be recreated on demand.

This makes it practical to destroy non-production environments when not in use.

---

# Cost Monitoring

AWS provides several services for monitoring expenditure.

Recommended services include:

- AWS Cost Explorer
- AWS Budgets
- AWS Cost and Usage Reports
- Amazon CloudWatch

These services help identify unusual spending and forecast future costs.

---

# Cost Management Recommendations

To minimise expenses during development:

- Destroy infrastructure when not in use.
- Keep Auto Scaling limits conservative.
- Use small EC2 instance types where appropriate.
- Minitor CloudFront traffic.
- Remove unused S3 objects.
- Review AWS Cost Explorer regularly.
- Configure AWS Budgets with spending alerts.

---

# Resource Cleanup

After completing the project, resources should be removed to prevent unnecessary changes.

Terraform simplifies this process.

```bash
terraform destroy
```

Always verify that all billable resources have been removed from the AWS Management Console after destruction.

---

# Conclusion

The MathLab AI Infrastructure has been designed to balance functionality, availability, security, and operational cost.

While services such as the NAT Gateway, Application Load Balancer, and CloudFront introduce ongoing charges, they provide essential capabilities required for a production-grade architecture.

By combining Infrastructure as Code with AWS cost management best practices, the infrastructure remains both maintainable and economically efficient.
