# Scripts

## Overview

The `scripts/` directory contains automation scripts used throughout the project lifecycle. These scripts standardize common Terraform, AWS, packaging, testing, deployment, and maintenance tasks.

## Objectives

The scripts are designed to:

- Simplify repetitive tasks
- Standardize development workflows
- Improve reproducibility
- Reduce human error
- Support CI/CD pipelines

## Usage

All scripts should be executed from the project root unless otherwise specified.

Example:

```bash
./scripts/init.sh
./scripts/validate.sh
./scripts/plan.sh
./scripts/apply.sh
```

## Script Categories

| Category     | Purpose                                    |
| ------------ | ------------------------------------------ |
| Terraform    | Initialize, validate, plan, apply, destroy |
| Testing      | Execute Terraform and infrastructure tests |
| Packaging    | Build website deployment package           |
| Deployment   | Upload assets and deploy infrastructure    |
| Verification | Validate deployed infrastructure           |
| Maintenance  | Cleanup temporary files                    |
