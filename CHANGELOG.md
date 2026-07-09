# Changelog

All notable changes to this project are documented in this file.

The format follows the principles of Keep a Changelog and Semantic Versioning (SemVer).

---

## [1.0.0] - 2026-07-08

### Added

#### Infrastructure

- Modular Terraform architecture
- Environment-based deployment structure
- Production deployment configuration
- Reusable Terraform modules

#### Networking

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Route Table Associations

#### Security

- Application Load Balancer Security Group
- EC2 Security Group
- Least-Privilege IAM Roles
- IAM Instance Profile
- IAM Policies
- IMDSv2 enforcement
- Encrypted EBS volumes
- Secure S3 bucket configuration

#### Storage

- Amazon S3 Assets Bucket
- Bucket Versioning
- Server-Side Encryption
- Public Access Block
- Lifecycle Policies

#### Compute

- EC2 Launch Template
- Auto Scaling Group
- Auto Scaling Policies

#### Load Balancing

- Application Load Balancer
- Target Group
- HTTP Listener

#### CDN

- CloudFront Distribution
- Origin Access Control
- Static Asset Caching

#### DNS

- Route 53 Hosted Zone Module
- Route 53 DNS Records Module

#### SSL

- AWS Certificate Manager Module
- Automated DNS Validation

#### Monitoring

- CloudWatch Module
- Auto Scaling Metrics

#### Templates

- EC2 Bootstrap Script
- Automated Website Deployment

#### Documentation

- README
- CHANGELOG
- ARCHITECTURE
- DEPLOYMENT
- OPERATIONS
- SECURITY
- TESTING
- TROUBLESHOOTING
- DECISIONS
- COST_ESTIMATION

#### Testing

- Terraform Validation Framework
- Infrastructure Test Framework

---

### Changed

- Refactored infrastructure into reusable Terraform modules.
- Improved naming consistency across modules.
- Updated Terraform outputs for modular integration.
- Standardised variable naming.
- Improved resource tagging strategy.
- Enhanced bootstrap automation.
- Improved CloudFront integration.
- Improved Route 53 integration.
- Improved ACM integration.
- Improved Auto Scaling configuration.

---

### Security

- Enforced least privilege IAM access.
- Blocked public acces to S3.
- Enabled HTTPS through ACM.
- Enabled CloudFront Origin Access Control.
- Enabled IMDSv2.
- Enabled encrypted EBS volumes.
- Enabeld encrypted S3 storage.

---

### Fixed

- Corrected Terraform module dependencies.
- Fixed CloudFront and ACM integration.
- Fixed Route 53 alias configuration.
- Corrected Launch Template bootstrap path.
- Fixed IAM policy references.
- Corrected S3 outputs.
- Fixed Terraform validation issues.
- Corrected Auto Scaling dependencies.
- Fixed CloudFront distribution configuration.

---

### Documentation

- Added production deployment documentation.
- Added architecture documenetation.
- Added testing documentation.
- Added operational documentation.
- Added security documentation.
- Added troubleshooting documentation.

---

### Notes

Initial production-ready release prepared for deployment to AWS.

Repository documentation completed to engineering standards.

Terraform validation and planning completed successfully.

Infrastructure ready for deployment.
