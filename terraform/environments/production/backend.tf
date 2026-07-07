terraform {
  /*
    The project intentionally uses Terraform's default local backend
    during the initial implementation.

    This allows any engineer to clone the repository and immediately run:

      terraform init
      terraform validate
      terraform plan

    without provisioning additional AWS infrastructure.

    The backend configuration can later be migrated to Amazon S3
    with DynamoDB state locking if the deployment model changes.
  */
}
