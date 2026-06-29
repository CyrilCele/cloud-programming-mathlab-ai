locals {
    common_tags = {
        Project     = var.project_name
        Environment = "Development"
        ManagedBy   = "Terraform"
    }
}