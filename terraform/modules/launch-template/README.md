# Launch Template Module

## Overview

The Launch Template module provisions the Amazon EC2 Launch Template used by the Auto Scaling Group to create web server instances for the MathLab AI Infrastructure.

The Launch Template defines the complete EC2 instance configuration, including the Amazon Machine Image (AMI), instance type, storage configuration, IAM Instance Profile, network settings, security groups, monitoring, metadata options, and automated bootstrap process.

Every EC2 instance launched by the Auto Scaling Group is created from this template, ensuring consistency, repeatability, and Infrastructure as Code (IaC) compliance.

---

# Features

- Creates an EC2 Launch Template
- Configures the Amazon Machine Image (AMI)
- Defines the EC2 instance type
- Associates an IAM Instance Profile
- Attaches the EC2 Security Group
- Executes automated bootstrap scripts
- Enables detailed monitoring
- Configures encrypted EBS storage
- Enforces IMDSv2
- Applies consistent resource tagging

---

# Resources Created

| Resource            | Purpose                                      |
| ------------------- | -------------------------------------------- |
| EC2 Launch Template | Standardised configuration for EC2 instances |

---

# Architecture

```text
                 Auto Scaling Group
                         │
                         ▼
                 Launch Template
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
      AMI          Bootstrap Script   Security Group
        │                │                │
        ▼                ▼                ▼
  EC2 Instance     Website Installed   Network Security
```

Each EC2 instance launched by the Auto Scaling Group is configured identically using this template.

---

# Bootstrap Process

When a new EC2 instance launches, the Launch Template executes the bootstrap script automatically.

The bootstrap process performs the following tasks:

1. Updates the operating system.
2. Installs Nginx.
3. Installs AWS CLI.
4. Installs unzip.
5. Downloads `website.zip` from Amazon S3.
6. Extracts the website into `/var/www/html`.
7. Configures file ownership and permissions.
8. Restarts the Nginx service.

This process enables fully automated provisioning without manual intervention.

---

# Storage Configuration

The Launch Template provisions encrypted Amazon EBS storage.

| Setting               | Value |
| --------------------- | ----- |
| Volume Type           | gp3   |
| Size                  | 20 GB |
| Encrypted             | Yes   |
| Delete on Termination | Yes   |

Encryption protects data at rest while automatic deletion prevents orphaned storage volumes.

---

# Instance Metadata Service (IMDSv2)

The Launch Template enforces the use of Instance Metadata Service Version 2 (IMDSv2).

| Setting                | Value    |
| ---------------------- | -------- |
| HTTP Endpoint          | Enabled  |
| HTTP Tokens            | Required |
| Instance Metadata Tags | Enabled  |

Using IMDSv2 mitigates several common attack vectors, including Server-Side Request Forgery (SSRF).

---

# Monitoring

Detailed monitoring is enabled for all EC2 instances.

This allows Amazon CloudWatch to collect metrics such as:

- CPU Utilisation
- Network In
- Network Out
- Disk Operations
- Status Checks

These metrics support operational monitoring and future scaling policies.

---

# Network Configuration

Instances launched from this template:

- Receive no public IP address.
- Are deployed into private subnets.
- Communicate with the Internet through the NAT Gateway.
- Receive inbound traffic only from the Application Load Balancer.

This architecture significantly reduces the attack surface.

---

# Inputs

| Name                  | Description                                | Type        | Required |
| --------------------- | ------------------------------------------ | ----------- | -------- |
| project_name          | Project name used for naming AWS resources | string      | Yes      |
| environment           | Deployment environment                     | string      | Yes      |
| ami_id                | Amazon Machine Image ID                    | string      | Yes      |
| instance_type         | EC2 instance type                          | string      | Yes      |
| instance_profile_name | IAM Instance Profile                       | string      | Yes      |
| security_group_id     | EC2 Security Group ID                      | string      | Yes      |
| assets_bucket_name    | S3 bucket containing deployment artefacts  | string      | Yes      |
| tags                  | Common resource tags                       | map(string) | Yes      |

---

# Outputs

| Output                         | Description                    |
| ------------------------------ | ------------------------------ |
| launch_template_id             | Launch Template ID             |
| launch_template_arn            | Launch Template ARN            |
| launch_template_name           | Launch Template name           |
| launch_template_latest_version | Latest Launch Template version |

---

# Dependencies

This module depends on:

- IAM Module
- Security Group Module
- S3 Module

Required inputs:

- IAM Instance Profile
- EC2 Security Group
- Assets Bucket Name

The module is consumed by:

- Auto Scaling Group

---

# Example Usage

```hcl
module "launch_template" {
  source = "../../modules/launch-template"

  project_name = var.project_name
  environment  = var.environment

  ami_id                = var.ami_id
  instance_type         = var.instance_type
  instance_profile_name = module.iam.instance_profile_name
  security_group_id     = module.security_groups.ec2_security_group_id
  assets_bucket_name    = module.s3.bucket_name

  tags = local.common_tags
}
```

---

# Security Best Practices

The Launch Template implements multiple AWS security best practices, including:

- IAM Roles instead of static credentials
- Private subnet deployment
- Encrypted EBS volumes
- IMDSv2 enforcement
- Dedicated Security Groups
- Infrastructure as Code
- Automated provisioning
- Consistent resource tagging

These measures help reduce operational risk and improve the security posture of the infrastructure.

---

# Operational Notes

Any modification to the Launch Template creates a new template version.

The Auto Scaling Group automatically references the latest version, ensuring that newly launched EC2 instances incorporate the updated configuration.

Existing instances continue running until they are replaced through an Instance Refresh or scaling event.

---

# Maintenance

When updating this module:

- Validate the AMI ID.
- Review bootstrap script changes.
- Confirm IAM permissions.
- Verify EBS configuration.
- Ensure IMDSv2 remains enforced.
- Execute `terraform validate`.
- Review the Terraform execution plan before deployment.

---

# Future Enhancements

Potential improvements include:

- Automatic AMI selection using AWS Systems Manager Parameter Store
- Multiple launch template versions
- Spot Instance support
- Mixed Instances Policy
- Additional EBS volumes
- CloudWatch Agent installation
- AWS Systems Manager Agent (SSM) integration
- User data versioning

These enhancements extend production capabilities while remaining compatible with the existing architecture.

---

# Conclusion

The Launch Template module provides the standardised blueprint for every EC2 instance in the MathLab AI Infrastructure. By combining automated provisioning, secure configuration, encrypted storage, IMDSv2 enforcement, and integration with the Auto Scaling Group, it delivers a repeatable, scalable, and production-ready compute platform.
