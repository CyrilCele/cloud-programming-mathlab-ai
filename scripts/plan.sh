#!/usr/bin/env bash

set -euo pipefail

cd terraform/environments/production

terraform plan \
    -out=tfplan