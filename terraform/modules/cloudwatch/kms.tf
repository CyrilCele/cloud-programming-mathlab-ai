#########################################
# AWS Identity
#########################################

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

#########################################
# Observability KMS Key
#########################################

resource "aws_kms_key" "observability" {
  description             = "KMS key protecting ${var.project_name} CloudWatch Logs and SNS alerts"
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
        Sid    = "AllowCloudWatchLogsEncryption"
        Effect = "Allow"

        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
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
          ArnLike = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:${data.aws_partition.current.partition}:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:*"
          }
        }
      },
      {
        Sid    = "AllowSNSEncryption"
        Effect = "Allow"

        Principal = {
          Service = "sns.amazonaws.com"
        }

        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey*"
        ]

        Resource = "*"

        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Sid    = "AllowCloudWatchToPublishEncryptedAlerts"
        Effect = "Allow"

        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }

        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey*"
        ]

        Resource = "*"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-observability-kms"
    }
  )
}

resource "aws_kms_alias" "observability" {
  name          = "alias/${var.project_name}-observability"
  target_key_id = aws_kms_key.observability.key_id
}
