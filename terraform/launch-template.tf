/**
 * ============================================================================
 * EC2 LAUNCH TEMPLATE
 * ----------------------------------------------------------------------------
 * Defines the standard EC2 configuration used by the Auto Scaling Group.
 * ============================================================================
 */

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  key_name               = var.key_pair_name
  update_default_version = true
  vpc_security_group_ids = [aws_security_group.web.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = base64encode(file("${path.module}/userdata.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${var.project_name}-web"
      },
    )
  }
}
