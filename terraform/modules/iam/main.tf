#########################################
# IAM Role
#########################################

resource "aws_iam_role" "ec2" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
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
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]

        Resource = "*"
      },

      #########################################
      # CloudWatch Metrics
      #########################################

      {
        Effect   = "Allow"
        Action   = ["cloudwatch:PutMetricData"]
        Resource = "*"
      },

      #########################################
      # S3 Bucket Listing
      #########################################
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = [var.assets_bucket_arn]
      },

      #########################################
      # S3 Object Access
      #########################################

      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = ["${var.assets_bucket_arn}/*"]
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
