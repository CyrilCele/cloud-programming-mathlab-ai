# Deployment Guide

This document explains how to deploy the AWS Static Website Infrastructure using Terraform.

The project is designed so that another engineer can deploy the infrastructure using their own AWS account with minimal configuration.

---

# Deployment Overview

Infrastructure provisioning is performed entirely using Terraform.

The deployment process consists of the following stages:

1. Clone the repository.
2. Configure AWS credentials.
3. Configure Terraform variables.
4. Initialize Terraform.
5. Validate the configuration.
6. Review the execution plan.
7. Apply the infrastructure.
8. Verify the deployment.

---

# Prerequisites

Before deployment, ensure the following software is installed.

## Required Software

- Git
- Terraform
- AWS CLI
- Make (optional but recommended)

---

## AWS Account

You will need:

- An active AWS account.
- Permission to provision AWS resources.
- AWS CLI configured with valid credentials.

---

# Clone the Repository

```bash
git clone <repository-url>

cd mathlab-ai
```

---

# Configure AWS Credentials

Configure the AWS CLI using:

```bash
aws configure
```

Provide:

- AWS Access Key ID
- AWS Secret Access Key
- Default Region
- Default Output Format

Verify the configuration.

```bash
aws sts get-caller-identity
```

---

# Configure Terraform Variables

Navigate to the production environment.

```text
terraform/
└── environments/
    └── production/
```

Copy the example variables file.

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the values according to your AWS environment.

Typical variables include:

- AWS Region
- Project Name
- Environment Name
- Domain Name (if applicable)
- Availability Zones

Additional variables will be introduced as infrastructure components are implemented.

---

# Initialize Terraform

Initialize the working directory.

```bash
terraform init
```

Terraform downloads the required providers and prepares the working directory.

---

# Validate the Configuration

Validate the Terraform configuration.

```bash
terraform validate
```

Expected outcome:

```text
Success! The configuration is valid.
```

---

# Format Terraform Files

Ensure Terraform files are correctly formatted.

```bash
terraform fmt -recursive
```

---

# Review the Execution Plan

Generate an execution plan.

```bash
terraform plan
```

Review the planned infrastructure carefully before deployment.

---

# Deploy the Infrastructure

Provision the infrastructure.

```bash
terraform apply
```

Confirm the deployment when prompted.

Terraform provisions all configured AWS resources.

---

# Verify the Deployment

After deployment, verify:

- Terraform completed successfully.
- AWS resources were created.
- EC2 instances are running.
- Auto Scaling Group is healthy.
- Load Balancer is operational.
- CloudFront distribution is deployed.
- Website is accessible.

Additional verification steps will be documented as each milestone is completed.

---

# Destroy the Infrastructure

To remove all deployed resources:

```bash
terraform destroy
```

Confirm the operation when prompted.

---

# Deployment Order

The infrastructure is deployed in the following logical order.

1. Networking
2. IAM
3. Security Groups
4. S3
5. CloudFront
6. Launch Template
7. Application Load Balancer
8. Auto Scaling Group
9. CloudWatch
10. Route 53

Terraform automatically determines resource dependencies.

---

# Deployment Verification Checklist

After deployment, verify:

- VPC created.
- Public subnets available.
- Security Groups configured.
- IAM roles attached.
- EC2 instances healthy.
- Nginx installed.
- Website deployed.
- Application Load Balancer healthy.
- Auto Scaling operational.
- CloudWatch monitoring active.
- Route 53 records resolving.
- CloudFront serving content.

---

# Updating the Website

The infrastructure is designed so that the website can be updated independently.

Typical workflow:

1. Replace the files inside the `website/` directory.
2. Commit the changes.
3. Redeploy the application (if required).

Infrastructure changes are not required unless the hosting architecture changes.

---

# Troubleshooting

If deployment fails:

1. Review the Terraform error message.
2. Validate the configuration.
3. Verify AWS credentials.
4. Confirm required AWS permissions.
5. Check AWS service quotas.
6. Review CloudWatch logs (where applicable).

Additional troubleshooting guidance is provided in `TROUBLESHOOTING.md`.

---

# Security Considerations

Never commit:

- `terraform.tfvars`
- AWS credentials
- Private keys
- Terraform state files

Always follow the Principle of Least Privilege when configuring AWS credentials.

---

# Future Enhancements

This document will be updated as the project progresses.

Future milestones will include:

- Backend state configuration
- Multi-AZ deployment details
- CloudFront deployment notes
- Auto Scaling verification
- Monitoring verification
- DNS configuration
- HTTPS configuration
- Production validation procedures

---

# Deployment Status

| Component                 | Status         |
| ------------------------- | -------------- |
| Repository                | ✅ Complete    |
| Documentation             | 🟡 In Progress |
| Terraform Bootstrap       | ⏳ Pending     |
| Networking                | ⏳ Pending     |
| IAM                       | ⏳ Pending     |
| S3                        | ⏳ Pending     |
| CloudFront                | ⏳ Pending     |
| Launch Template           | ⏳ Pending     |
| Application Load Balancer | ⏳ Pending     |
| Auto Scaling              | ⏳ Pending     |
| CloudWatch                | ⏳ Pending     |
| Route 53                  | ⏳ Pending     |
| Production Hardening      | ⏳ Pending     |
| Final Validation          | ⏳ Pending     |
