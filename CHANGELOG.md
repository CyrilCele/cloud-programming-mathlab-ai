# Changelog

All notable changes to this project are documented in this file.

The format is based on Keep a Changelog and this project follows Semantic Versioning where applicable.

---

## [Unreleased]

### Planned

- IAM Roles and Policies
- EC2 Instance Profile
- Amazon S3
- CloudFront Distribution
- Launch Template
- EC2 Auto Scaling Group
- Application Load Balancer
- CloudWatch Monitoring
- Route 53
- GitHub Actions CI/CD
- Production Hardening
- Final Infrastructure Validation

---

## [0.4.0] - Milestone 4

### Added

#### Amazon S3

- Reusable S3 Terraform module
- Private S3 bucket
- Bucket versioning
- Server-side encryption (AES-256)
- Block Public Access
- Lifecycle configuration

#### Terraform

- Production environment integration
- S3 outputs
- Configurable globally unique bucket name

#### Documentation

- Updated README.md
- Updated ARCHITECTURE.md
- Updated DEPLOYMENT.md
- Updated SECURITY.md
- Updated COST_ESTIMATION.md

---

## [0.3.0] - Milestone 3

### Added

#### Identity and Access Management

- EC2 IAM Role
- EC2 Instance Profile
- Reusable IAM Terraform module
- Production environment integration

#### Documentation

- Updated README.md
- Updated ARCHITECTURE.md
- Updated DEPLOYMENT.md
- Updated SECURITY.md

---

## [0.2.0] - Milestone 2

### Added

#### Networking

- Production-ready VPC
- Internet Gateway
- Public Subnets
- Private Subnets
- Public Route Table
- Private Route Table
- Route Table Associations
- NAT Gateway
- Elastic IP for NAT Gateway

#### Security

- Application Load Balancer Security Group
- EC2 Security Group
- Least Privilege network access
- Private EC2 architecture
- Public ALB architecture

#### Terraform

- Networking module
- Security Groups module
- Environment integration
- Module outputs
- Module variables
- Common resource tagging

#### Documentation

- Updated README.md
- Updated ARCHITECTURE.md
- Updated DEPLOYMENT.md

---

## [0.1.0] - Milestone 1

### Added

#### Repository

- Professional repository structure
- Terraform project structure
- Modular architecture
- Environment separation

#### Terraform

- Provider configuration
- Version constraints
- Variables
- Outputs
- Locals
- Data sources
- Backend configuration
- Example variable file

#### Documentation

- Initial README.md
- Initial project documentation
- Deployment structure

#### Project Files

- LICENSE
- .gitignore
- Makefile
