#########################################
# AWS Identity
#########################################

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

#########################################
# Assets KMS Key
#########################################

resource "aws_kms_key" "assets" {
  description             = "KMS key protecting objects in ${var.bucket_name}"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "EnableAccountAdministration"
        Effect = "Allow"

        Principal = {
          AWS = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowAccountPrincipalsToUseKeyThroughS3"
        Effect = "Allow"

        Principal = {
          AWS = "*"
        }

        Action = [
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:GenerateDataKey*",
          "kms:ReEncrypt*"
        ]

        Resource = "*"

        Condition = {
          StringEquals = {
            "aws:PrincipalAccount" = data.aws_caller_identity.current.account_id
            "kms:ViaService"       = "s3.${var.aws_region}.amazonaws.com"
          }
        }
      },
      {
        Sid    = "AllowCloudFrontToDecryptAssets"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ]

        Resource = "*"

        Condition = {
          StringEquals = {
            "AWS:SourceAccount" = data.aws_caller_identity.current.account_id
          }

          ArnLike = {
            "AWS:SourceArn" = "arn:${data.aws_partition.current.partition}:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.bucket_name}-kms"
    }
  )
}

resource "aws_kms_alias" "assets" {
  name          = "alias/${var.bucket_name}"
  target_key_id = aws_kms_key.assets.key_id
}

#########################################
# S3 Bucket
#########################################

#checkov:skip=CKV2_AWS_62:The assets bucket has no approved event-driven consumer; creating an unused notification destination would add cost and dead infrastructure.
resource "aws_s3_bucket" "assets" {
  bucket = var.bucket_name

  force_destroy = true

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}

#########################################
# Server Access Logging
#########################################

resource "aws_s3_bucket_logging" "assets" {
  bucket = aws_s3_bucket.assets.id

  target_bucket = var.access_logs_bucket_id
  target_prefix = var.access_logs_prefix
}

#########################################
# Versioning
#########################################

resource "aws_s3_bucket_versioning" "assets" {
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}

#########################################
# KMS Server-Side Encryption
#########################################

resource "aws_s3_bucket_server_side_encryption_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.assets.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_object" "website" {
  bucket = aws_s3_bucket.assets.id
  key    = "website.zip"

  source = var.website_zip_path

  server_side_encryption = "aws:kms"
  kms_key_id             = aws_kms_key.assets.arn

  source_hash = filemd5(var.website_zip_path)

  depends_on = [
    aws_s3_bucket_public_access_block.assets,
    aws_s3_bucket_server_side_encryption_configuration.assets,
    aws_s3_bucket_versioning.assets
  ]
}

#########################################
# Public Access Block
#########################################

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

#########################################
# Lifecycle Configuration
#########################################

resource "aws_s3_bucket_lifecycle_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
