# Contributing

## Overview

Thank you for your interest in contributing to the MathLab AI Infrastructure project.

Although this repository was developed as part of a university project, contributions that improve quality, maintainability, security, and documentation are welcome.

## Prerequisites

Before contributing, ensure you have:

- Git
- Terraform 1.13 or later
- AWS CLI v2
- An AWS account
- Bash (Git Bash on Windows is supported)

## Development Workflow

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Run all validation scripts:

```bash
./scripts/fmt.sh
./scripts/validate.sh
./scripts/test.sh
./scripts/lint.sh
```

5. Commit using descriptive commit messages.
6. Open a Pull Request.

## Coding Standards

### Terraform

- Use four-space indentation.
- Group related resources logically.
- Provide descriptions for variables and outputs.
- Tag all AWS resources.
- Follow least-privilege IAM principles.

### Shell Scripts

- Use Bash.
- Enable:

```bash
set -euo pipefail
```

- Quote variables.
- Use descriptive function names.
- Keep scripts modular.

### Documentation

- Update documentation whenever infrastructure changes.
- Maintain consistent Markdown formatting.
- Keep architecture diagrams synchronized with the implementation.

## Pull Requests

Each pull request should:

- Address a single concern.
- Include updated documentation if required.
- Pass all automated tests.
- Be reviewed before merging.

## Reporting Issues

Please include:

- Terraform version
- AWS Region
- Operating system
- Error messages
- Steps to reproduce
