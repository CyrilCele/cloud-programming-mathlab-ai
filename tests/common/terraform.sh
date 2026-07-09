#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/paths.sh"

terraform_fmt() {

    (
        cd "$TF_ROOT"
        terraform fmt -recursive -check
    )
}

terraform_validate() {

    (
        cd "$TF_ROOT"
        terraform validate
    )
}

terraform_plan() {

    (
        cd "$TF_ROOT"
        terraform plan -input=false
    )
}