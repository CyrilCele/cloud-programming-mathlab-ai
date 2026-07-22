#########################################
# AWS Identity
#########################################

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

#########################################
# IAM Role
#########################################

resource "aws_iam_role" "ec2" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowEC2AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2-role"
    }
  )
}

#########################################
# IAM Policy
#########################################

resource "aws_iam_role_policy" "ec2" {
  name = "${var.project_name}-ec2-policy"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      #########################################
      # CloudWatch Logs
      #########################################

      {
        Sid    = "WriteProjectApplicationLogs"
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]

        Resource = [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:*${var.project_name}*",
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:*${var.project_name}*:log-stream:*"
        ]
      },

      #########################################
      # CloudWatch Metrics
      #########################################

      {
        Sid      = "PublishProjectMetrics"
        Effect   = "Allow"
        Action   = ["cloudwatch:PutMetricData"]
        Resource = "*"

        Condition = {
          StringEquals = {
            "cloudwatch:namespace" = var.cloudwatch_metric_namespace
          }
        }
      },

      #########################################
      # S3 Bucket Listing
      #########################################

      {
        Sid      = "ListAssetsBucket"
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = var.assets_bucket_arn
      },

      #########################################
      # S3 Object Access
      #########################################

      {
        Sid      = "ReadAssetsObjects"
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${var.assets_bucket_arn}/*"
      }
    ]
  })
}

#########################################
# Instance Profile
#########################################

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2.name
}
