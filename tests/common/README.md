# Test Framework

## Overview

The MathLab AI project uses a shared Bash testing framework for all repository validation.

The framework is divided into three suites:

- Repository Quality
- Terraform
- Infrastructure

All suites share a common utility library located in:

tests/common/utils.sh

## Features

- Shared assertions
- Shared logging
- Terraform helper functions
- Consistent path resolution
- Unified reporting

## Running Tests

Run all tests:

```bash
./scripts/test.sh
```
