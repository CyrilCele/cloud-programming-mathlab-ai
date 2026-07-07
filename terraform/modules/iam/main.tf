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

resource "aws_iam_policy" "ec2" {
  name        = "${var.project_name}-ec2-policy"
  description = "Least privilege policy for EC2 instances."

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = []
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2-policy"
    }
  )
}

#########################################
# Policy Attachment
#########################################

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2.arn
}

#########################################
# Instance Profile
#########################################

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2.name
}
