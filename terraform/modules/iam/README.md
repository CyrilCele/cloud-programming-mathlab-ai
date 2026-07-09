# IAM Module

## Overview

The IAM module provisions the Identity and Access Management (IAM) resources required by the MathLab AI Infrastructure.

It creates an IAM Role, IAM Policy, and IAM Instance Profile that provide EC2 instances with secure, temporary credentials to access AWS services without storing long-term access keys.

The module follows the Principle of Least Privilege by granting only the permissions required for the application to function.

---

# Features

- Creates an EC2 IAM Role
- Creates an IAM Policy
- Attaches the policy to the IAM Role
- Creates an EC2 Instance Profile
- Supports secure access to Amazon S3
- Eliminates the need for hard-coded AWS credentials
- Applies consistent resource tagging

---

# Resources Created

| Resource                   | Purpose                                    |
| -------------------------- | ------------------------------------------ |
| IAM Role                   | Assumed by EC2 instances                   |
| IAM Policy                 | Defines allowed AWS actions                |
| IAM Role Policy Attachment | Attaches the policy to the role            |
| IAM Instance Profile       | Associates the IAM Role with EC2 instances |

---

# Security Design

The IAM module implements AWS best practices by using temporary credentials provided through an Instance Profile.

```
EC2 Instance
      │
      ▼
IAM Instance Profile
      │
      ▼
IAM Role
      │
      ▼
IAM Policy
      │
      ▼
Amazon S3
```

No AWS Access Keys or Secret Access Keys are stored on EC2 instances.

---

# Permissions

The default policy grants the minimum permissions required for the application.

Current permissions include:

| Service   | Action    |
| --------- | --------- |
| Amazon S3 | GetObject |

Access is limited to the configured assets bucket.

Future permissions should be added only when required.

---

# Inputs

| Name              | Description                                | Type        | Required |
| ----------------- | ------------------------------------------ | ----------- | -------- |
| project_name      | Project name used for naming AWS resources | string      | Yes      |
| assets_bucket_arn | ARN of the S3 assets bucket                | string      | Yes      |
| tags              | Common resource tags                       | map(string) | Yes      |

---

# Outputs

| Output                | Description           |
| --------------------- | --------------------- |
| ec2_role_name         | IAM Role name         |
| ec2_role_arn          | IAM Role ARN          |
| instance_profile_name | Instance Profile name |
| instance_profile_arn  | Instance Profile ARN  |

---

# Dependencies

This module depends on:

- Amazon S3 Module

Required input:

- S3 Bucket ARN

---

# Security Best Practices

This module follows AWS IAM best practices by:

- Using IAM Roles instead of access keys
- Applying the Principle of Least Privilege
- Restricting permissions to required AWS resources
- Providing temporary AWS credentials
- Preventing credential exposure
- Supporting Infrastructure as Code

---

# Example Usage

```hcl
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name

  assets_bucket_arn = module.s3.bucket_arn

  tags = local.common_tags
}
```

---

# Operational Notes

The Instance Profile created by this module is attached to the EC2 Launch Template.

During instance startup, AWS automatically provides temporary credentials through the Instance Metadata Service (IMDSv2). These credentials are used by the bootstrap script to securely download the website package from Amazon S3.

No manual credential management is required.

---

# Maintenance

When updating this module:

- Review all IAM permissions.
- Grant only the permissions required.
- Avoid wildcard (`*`) permissions whenever possible.
- Validate the IAM policy using Terraform.
- Review changes before deployment.

---

# Future Enhancements

Possible future improvements include:

- CloudWatch logging permissions
- AWS Systems Manager (SSM) permissions
- Secrets Manager integration
- Parameter Store integration
- Fine-grained IAM conditions
- Service Control Policies (SCPs)

These enhancements are outside the scope of the current project but represent recommended production practices.

---

# Conclusion

The IAM module provides secure identity management for the MathLab AI Infrastructure by supplying EC2 instances with temporary AWS credentials through an IAM Instance Profile. By following the Principle of Least Privilege and eliminating long-term credentials, the module contributes to a secure, maintainable, and production-ready cloud environment.
