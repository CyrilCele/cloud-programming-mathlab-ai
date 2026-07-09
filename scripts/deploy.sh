#!/usr/bin/env bash

set -euo pipefail

bash scripts/package-website.sh

bash scripts/init.sh

bash scripts/fmt.sh

bash scripts/validate.sh

bash scripts/plan.sh

bash scripts/apply.sh

bash scripts/upload-assets.sh

bash scripts/verify.sh