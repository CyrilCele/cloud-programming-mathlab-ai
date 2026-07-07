module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name

  vpc_cidr = var.vpc_cidr

  availability_zones = local.availability_zones

  public_subnet_cidr_a = var.public_subnet_cidr_a
  public_subnet_cidr_b = var.public_subnet_cidr_b

  private_subnet_cidr_a = var.private_subnet_cidr_a
  private_subnet_cidr_b = var.private_subnet_cidr_b

  tags = local.common_tags
}

module "security_groups" {
  source = "../../modules/security-group"

  project_name = var.project_name
  vpc_id       = module.networking.vpc_id

  tags = local.common_tags
}
