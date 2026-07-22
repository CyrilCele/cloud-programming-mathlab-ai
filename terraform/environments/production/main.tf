module "networking" {
  source             = "../../modules/networking"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = local.availability_zones

  public_subnet_cidr_a = var.public_subnet_cidr_a
  public_subnet_cidr_b = var.public_subnet_cidr_b

  private_subnet_cidr_a = var.private_subnet_cidr_a
  private_subnet_cidr_b = var.private_subnet_cidr_b

  flow_logs_bucket_arn = aws_s3_bucket.access_logs.arn

  tags = local.common_tags

  depends_on = [
    aws_s3_bucket_policy.access_logs
  ]
}

module "security_groups" {
  source       = "../../modules/security-group"
  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
  tags         = local.common_tags
}

module "iam" {
  source = "../../modules/iam"

  project_name                = var.project_name
  assets_bucket_arn           = module.s3.bucket_arn
  cloudwatch_metric_namespace = "${var.project_name}/Application"

  tags = local.common_tags
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.assets_bucket_name
  aws_region  = var.aws_region
  tags        = local.common_tags
}

module "alb" {
  source            = "../../modules/alb"
  project_name      = var.resource_prefix
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id

  access_logs_bucket_name    = aws_s3_bucket.access_logs.id
  access_logs_bucket_prefix  = "alb"
  enable_deletion_protection = true

  tags = local.common_tags

  depends_on = [
    aws_s3_bucket_policy.access_logs
  ]
}

module "launch_template" {
  source       = "../../modules/launch-template"
  project_name = var.project_name
  ami_id       = data.aws_ami.amazon_linux.id

  instance_type         = var.instance_type
  instance_profile_name = module.iam.instance_profile_name

  security_group_id  = module.security_groups.ec2_security_group_id
  assets_bucket_name = module.s3.bucket_name
  tags               = local.common_tags
}

module "autoscaling" {
  source       = "../../modules/autoscaling"
  project_name = var.project_name

  launch_template_id             = module.launch_template.launch_template_id
  launch_template_latest_version = module.launch_template.launch_template_latest_version

  private_subnet_ids = module.networking.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  tags               = local.common_tags
}

module "route53_zone" {
  source      = "../../modules/route53-zone"
  domain_name = var.domain_name
  tags        = local.common_tags
}

module "acm" {
  source         = "../../modules/acm"
  domain_name    = var.domain_name
  hosted_zone_id = module.route53_zone.hosted_zone_id
  tags           = local.common_tags
}

module "cloudfront" {
  source                             = "../../modules/cloudfront"
  project_name                       = var.project_name
  alb_dns_name                       = module.alb.alb_dns_name
  assets_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  certificate_arn                    = module.acm.certificate_arn
  domain_name                        = var.domain_name

  access_logs_bucket_domain_name = aws_s3_bucket.access_logs.bucket_domain_name
  access_logs_prefix             = "cloudfront/"

  tags = local.common_tags

  depends_on = [
    aws_s3_bucket_ownership_controls.access_logs
  ]
}

module "route53_records" {
  source         = "../../modules/route53-records"
  hosted_zone_id = module.route53_zone.hosted_zone_id
  domain_name    = var.domain_name

  cloudfront_domain_name    = module.cloudfront.distribution_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}

module "cloudwatch" {
  source                   = "../../modules/cloudwatch"
  project_name             = var.project_name
  aws_region               = var.aws_region
  autoscaling_group_name   = module.autoscaling.autoscaling_group_name
  load_balancer_arn_suffix = module.alb.alb_arn_suffix
  target_group_arn_suffix  = module.alb.target_group_arn_suffix
  alert_email              = var.alert_email
  log_retention_days       = var.log_retention_days
  tags                     = local.common_tags
}

resource "aws_s3_bucket_policy" "cloudfront" {
  depends_on = [module.cloudfront]
  bucket     = module.s3.bucket_id

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
