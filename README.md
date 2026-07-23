# AWS Terraform Infrastructure Project

## Overview

This project provisions production-ready infrastructure on **Amazon Web Services (AWS)** using **Terraform Infrastructure as Code (IaC)**.

The infrastructure hosts a static website behind a secure, highly available, and scalable AWS architecture. The project emphasizes:

- Infrastructure automation
- Reproducible deployments
- Security hardening
- High availability
- Operational visibility
- Maintainable Terraform modules
- Automated validation through GitHub Actions

The project was developed as part of a university cloud computing assignment and is structured so that another developer, reviewer, or lecturer can validate, deploy, verify, and remove the environment consistently.

---

## Architecture

The deployed architecture includes:

- Amazon Virtual Private Cloud
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables
- Security groups
- IAM roles
- IAM instance profiles
- EC2 launch templates
- Auto Scaling Group
- Application Load Balancer
- Amazon EC2 instances running Amazon Linux 2023
- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager
- Amazon CloudWatch
- AWS WAF
- VPC Flow Logs
- Centralized access logging

The public request path follows this general flow:

```text
Client
  |
  v
Amazon Route 53
  |
  v
Amazon CloudFront
  |
  v
AWS WAF
  |
  v
Application Load Balancer
  |
  v
Auto Scaling Group
  |
  v
Amazon EC2
```

Website content is stored in Amazon S3 and retrieved by EC2 instances during bootstrap.

---

## Repository Structure

```text
.
├── .github/
│   ├── .checkov.yaml
│   └── workflows/
├── docs/
│   ├── DEPLOYMENT.md
│   ├── QUICK_START.md
│   └── TESTING.md
├── scripts/
│   ├── cleanup.sh
│   ├── deploy.sh
│   ├── destroy.sh
│   ├── prerequisites.sh
│   ├── quality.sh
│   └── verify.sh
├── terraform/
│   ├── environments/
│   │   └── production/
│   ├── modules/
│   └── templates/
├── website/
├── LICENSE
├── Makefile
└── README.md
```

The exact contents of individual Terraform modules may evolve, but the repository is organized around reusable infrastructure modules, a production environment, automation scripts, documentation, and continuous integration workflows.

---

## Requirements

Install the following software before working with the project:

- Terraform `1.13.x`
- AWS CLI v2
- Git
- Bash
- GNU Make

On Windows, Bash commands can be run through Git Bash.

Verify the required tools:

```bash
terraform version
aws --version
git --version
bash --version
make --version
```

The installed Terraform version should be compatible with the version configured by the repository and its GitHub Actions workflows.

---

## Install Prerequisites

The repository includes an automated installer that installs all required local development tools.

Run:

```bash
bash scripts/install.sh
```

The installer installs or updates:

- Terraform 1.13.x
- AWS CLI v2
- Git
- curl
- unzip

After installation, verify the environment:

```bash
bash scripts/prerequisites.sh
```

A successful validation confirms:

- Terraform installed
- AWS CLI installed
- Git installed
- curl installed
- unzip installed
- AWS credentials configured
- AWS region configured

---

## AWS Authentication

Configure AWS credentials:

```bash
aws configure
```

Verify the active AWS identity:

```bash
aws sts get-caller-identity
```

The authenticated principal must have sufficient permissions to provision and manage the AWS resources defined by the Terraform configuration.

Do not commit AWS access keys, secret keys, session tokens, local credential files, or generated Terraform state files to the repository.

---

## Quick Start

Clone the repository:

```bash
git clone <repository-url>
cd <repository-folder>
```

Verify local prerequisites:

```bash
make prerequisites
```

Run the repository quality checks:

```bash
make quality
```

Deploy the infrastructure:

```bash
make deploy
```

Verify the deployment:

```bash
make verify
```

The equivalent scripts are also available directly:

```bash
bash scripts/prerequisites.sh
bash scripts/quality.sh
bash scripts/deploy.sh
bash scripts/verify.sh
```

---

## Deployment Workflow

The automated deployment workflow performs the following operations:

1. Verifies local dependencies.
2. Verifies AWS authentication.
3. Initializes Terraform.
4. Formats the Terraform configuration.
5. Validates the Terraform configuration.
6. Generates and reviews a Terraform execution plan.
7. Provisions the AWS infrastructure.
8. Configures networking and routing.
9. Creates security controls and IAM resources.
10. Creates the Application Load Balancer.
11. Creates the launch template and Auto Scaling Group.
12. Launches and bootstraps EC2 instances.
13. Configures CloudFront, Route 53, ACM, and AWS WAF.
14. Deploys or exposes the website content.
15. Verifies infrastructure health and website availability.

Deployment can be started with:

```bash
make deploy
```

or directly through the deployment script:

```bash
bash scripts/deploy.sh
```

For the full deployment procedure, see [Deployment Guide](docs/DEPLOYMENT.md).

---

## Quality Assurance

The repository includes automated validation for infrastructure correctness, code quality, security, and deployment readiness.

Quality checks include:

- Terraform formatting
- Terraform initialization
- Terraform validation
- Terraform planning
- TFLint static analysis
- Checkov security scanning
- Shell script validation
- Repository consistency checks
- Infrastructure verification
- Website availability verification

Run the complete local quality gate:

```bash
make quality
```

Equivalent script:

```bash
bash scripts/quality.sh
```

The quality workflow is designed to identify formatting, syntax, security, configuration, and integration issues before changes are pushed or deployed.

---

## Continuous Integration

The project uses **GitHub Actions** for continuous integration.

The workflows validate changes pushed to `main` and changes submitted through pull requests targeting `main`.

Automated CI checks include:

- Repository validation
- Terraform formatting
- Terraform initialization
- Terraform validation
- Terraform linting
- Checkov security scanning
- SARIF security-report generation
- Repository quality-script execution

GitHub Actions uses a pinned Terraform version compatible with Terraform `1.13.x`.

The CI workflows are located in:

```text
.github/workflows/
```

---

## Security Scanning

Infrastructure security is evaluated using:

- **Checkov** for Terraform policy and security scanning
- **TFLint** for Terraform linting and provider-aware static analysis

The governed Checkov configuration is stored in:

```text
.github/.checkov.yaml
```

Run Checkov directly:

```bash
checkov \
  --directory terraform \
  --config-file .github/.checkov.yaml
```

Run TFLint through the repository quality workflow:

```bash
make quality
```

Approved Checkov exclusions are documented in the repository configuration and should reflect deliberate architectural decisions rather than accidental omissions.

---

## Useful Commands

### Verify prerequisites

```bash
make prerequisites
```

Equivalent script:

```bash
bash scripts/prerequisites.sh
```

### Initialize Terraform

```bash
make init
```

Manual equivalent:

```bash
terraform -chdir=terraform/environments/production init
```

### Format Terraform

```bash
terraform fmt -recursive terraform
```

Check formatting without modifying files:

```bash
terraform fmt -recursive -check terraform
```

### Validate Terraform

```bash
make validate
```

Manual equivalent:

```bash
terraform -chdir=terraform/environments/production validate
```

### Create a Terraform plan

```bash
make plan
```

Manual equivalent:

```bash
terraform -chdir=terraform/environments/production plan
```

### Deploy infrastructure

```bash
make deploy
```

Equivalent script:

```bash
bash scripts/deploy.sh
```

### Verify infrastructure

```bash
make verify
```

Equivalent script:

```bash
bash scripts/verify.sh
```

### Run quality checks

```bash
make quality
```

Equivalent script:

```bash
bash scripts/quality.sh
```

### Destroy infrastructure

```bash
make destroy
```

Equivalent script:

```bash
bash scripts/destroy.sh
```

### Clean generated Terraform files

```bash
make cleanup
```

Equivalent script:

```bash
bash scripts/cleanup.sh
```

---

## Automation Scripts

The `scripts/` directory contains the repository automation entry points.

### `prerequisites.sh`

Verifies that the required local tools and dependencies are available.

```bash
bash scripts/prerequisites.sh
```

### `quality.sh`

Runs the local repository quality gate, including Terraform and security checks.

```bash
bash scripts/quality.sh
```

### `deploy.sh`

Initializes, validates, plans, and applies the Terraform infrastructure.

```bash
bash scripts/deploy.sh
```

### `verify.sh`

Validates the deployed infrastructure, Terraform outputs, AWS resources, and website availability.

```bash
bash scripts/verify.sh
```

### `destroy.sh`

Removes the provisioned AWS infrastructure.

```bash
bash scripts/destroy.sh
```

### `cleanup.sh`

Removes generated local Terraform artifacts and caches according to the repository cleanup policy.

```bash
bash scripts/cleanup.sh
```

The Makefile provides convenient commands that delegate to these scripts and Terraform operations.

---

## Security Features

The infrastructure incorporates multiple security controls, including:

- IAM least-privilege policies
- Encrypted EBS volumes
- HTTPS with AWS Certificate Manager
- CloudFront HTTPS enforcement
- AWS WAF protection
- Private EC2 instances
- Restricted security-group rules
- CloudFront-restricted ALB access
- IMDSv2 enforcement
- S3 Block Public Access
- S3 encryption
- S3 versioning
- Access logging
- VPC Flow Logs
- CloudWatch monitoring
- Centralized log storage
- Terraform security scanning
- CI security validation

Security-related Checkov exclusions are managed centrally through `.github/.checkov.yaml`.

---

## Website Deployment

During EC2 instance bootstrap:

1. The initialization script runs.
2. Nginx is installed.
3. The website archive is downloaded from Amazon S3.
4. The archive is extracted into the Nginx document root.
5. File ownership and permissions are configured.
6. Nginx is enabled and started.
7. The instance registers with the Application Load Balancer target group.

The default Nginx document root is:

```text
/usr/share/nginx/html
```

To update the website, create a new website archive and upload it to the configured S3 bucket:

```bash
aws s3 cp website.zip s3://<bucket-name>/website.zip
```

Then initiate an Auto Scaling instance refresh:

```bash
aws autoscaling start-instance-refresh \
  --auto-scaling-group-name <asg-name>
```

New EC2 instances will retrieve the updated website archive during bootstrap.

---

## Verification and Testing

Infrastructure verification includes:

- Terraform formatting
- Terraform validation
- Terraform planning
- AWS authentication checks
- Terraform output validation
- DNS resolution checks
- ACM certificate checks
- Application Load Balancer checks
- Target group health checks
- Auto Scaling Group checks
- S3 accessibility checks
- HTTPS connectivity checks
- Website HTTP response checks

Run automated verification:

```bash
make verify
```

Equivalent script:

```bash
bash scripts/verify.sh
```

A successful deployment should produce:

- A valid Terraform configuration
- A successful Terraform plan
- Healthy Application Load Balancer targets
- A valid ACM certificate
- Successful HTTPS connectivity
- A publicly accessible website through the configured domain
- Passing local and GitHub Actions quality checks

For the complete testing procedure, see [Testing Guide](docs/TESTING.md).

---

## Manual Verification

Verify the current AWS identity:

```bash
aws sts get-caller-identity
```

List Application Load Balancers:

```bash
aws elbv2 describe-load-balancers
```

Verify target group health:

```bash
aws elbv2 describe-target-health \
  --target-group-arn <target-group-arn>
```

Verify Auto Scaling Groups:

```bash
aws autoscaling describe-auto-scaling-groups
```

Verify the S3 bucket:

```bash
aws s3 ls s3://<bucket-name>
```

Verify Route 53 hosted zones:

```bash
aws route53 list-hosted-zones
```

Verify the website response:

```bash
curl -I https://<your-domain>
```

A healthy website should return a successful HTTPS response, normally HTTP `200`.

---

## Infrastructure Destruction

Destroy all provisioned infrastructure:

```bash
make destroy
```

Equivalent script:

```bash
bash scripts/destroy.sh
```

Review the Terraform destruction plan carefully before confirming.

S3 buckets containing objects or versioned objects may need to be emptied before Terraform can delete them. Confirm that retained logs, website archives, and state-related data are no longer required before removal.

---

## Terraform State

Terraform state may contain sensitive infrastructure data.

Production deployments should use an appropriately secured remote backend with:

- Encryption at rest
- Access controls
- State locking
- Versioning
- Restricted administrative access

Local Terraform state files must not be committed to Git.

---

## Technologies

- Terraform
- Amazon Web Services
- Amazon VPC
- Amazon EC2
- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager
- AWS WAF
- Elastic Load Balancing
- EC2 Auto Scaling
- Amazon CloudWatch
- AWS IAM
- Nginx
- Amazon Linux 2023
- TFLint
- Checkov
- Bash
- GNU Make
- Git
- GitHub Actions

---

## Documentation

Additional project documentation is available here:

- [Deployment Guide](docs/DEPLOYMENT.md)
- [Quick Start Guide](docs/QUICK_START.md)
- [Testing Guide](docs/TESTING.md)

---

## Official Documentation

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS Documentation](https://docs.aws.amazon.com/)
- [Amazon EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Amazon CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [Amazon Route 53 Documentation](https://docs.aws.amazon.com/route53/)
- [Elastic Load Balancing Documentation](https://docs.aws.amazon.com/elasticloadbalancing/)
- [EC2 Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/)
- [Amazon CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch/)
- [AWS IAM Documentation](https://docs.aws.amazon.com/iam/)
- [Amazon VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS WAF Documentation](https://docs.aws.amazon.com/waf/)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Checkov Documentation](https://www.checkov.io/)
- [TFLint Documentation](https://github.com/terraform-linters/tflint)

---

## License

This repository was created for academic purposes as part of a university cloud infrastructure project.

The project is licensed under the [MIT License](LICENSE).

---

## Author

**Nkululeko Cyril Cele**
