# Production Environment

This directory contains the Terraform configuration for the production environment.

## Purpose

The production environment provisions the AWS infrastructure required to host the static website.

Infrastructure is deployed using Terraform and follows AWS Well-Architected Framework principles.

## Files

| File                     | Purpose                                      |
| ------------------------ | -------------------------------------------- |
| backend.tf               | Terraform backend configuration              |
| providers.tf             | AWS provider configuration                   |
| versions.tf              | Terraform and provider version requirements  |
| variables.tf             | Input variables                              |
| locals.tf                | Local values shared across the configuration |
| data.tf                  | Terraform data sources                       |
| main.tf                  | Root module configuration                    |
| outputs.tf               | Terraform outputs                            |
| terraform.tfvars.example | Example variable definitions                 |

## Deployment

```bash
terraform init

terraform validate

terraform plan

terraform apply
```

Always review the execution plan before applying infrastructure changes.
