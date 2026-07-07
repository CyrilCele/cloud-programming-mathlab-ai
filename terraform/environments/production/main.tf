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

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  tags         = local.common_tags
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = var.assets_bucket_name

  tags = local.common_tags
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id

  tags = local.common_tags
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  launch_template_id             = module.launch_template.launch_template_id
  launch_template_latest_version = module.launch_template.launch_template_latest_version

  private_subnet_ids = module.networking.private_subnet_ids

  target_group_arn = module.alb.target_group_arn

  tags = local.common_tags
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  project_name = var.project_name

  alb_dns_name = module.alb.alb_dns_name

  assets_bucket_regional_domain_name = module.s3.bucket_regional_domain_name

  tags = local.common_tags
}

resource "aws_s3_bucket_policy" "cloudfront" {
  depends_on = [module.cloudfront]

  bucket = module.s3.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${module.s3.bucket_arn}/*"
        ]

        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.distribution_arn
          }
        }
      }
    ]
  })
}
