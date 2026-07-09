terraform {
  /*
  ==============================================================================
  Backend Configuration
  ==============================================================================

  This project intentionally uses Terraform's default local backend.

  Using the local backend allows the project to be cloned and executed
  immediately without first provisioning a remote Terraform state backend.

  New contributors can run:

      terraform init
      terraform validate
      terraform plan

  without requiring additional AWS resources.

  For collaborative or production deployments, the backend can be migrated
  to an Amazon S3 backend with DynamoDB state locking to provide:

    • Centralized state management
    • State locking
    • Versioning
    • Disaster recovery
    • Team collaboration

  Because this repository is intended for a university project and a
  single operator workflow, the default local backend is sufficient.
  ==============================================================================
  */
}
