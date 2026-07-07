resource "aws_launch_template" "this" {
  name_prefix = var.project_name

  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data = base64encode(
    templatefile(
      "${path.module}/../../../templates/bootstrap.sh.tftpl",
      {
        assets_bucket_name = var.assets_bucket_name
      }
    )
  )

  update_default_version               = true
  instance_initiated_shutdown_behavior = "terminate"

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = false

    security_groups = [
      var.security_group_id
    ]
  }

  monitoring {
    enabled = true
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"

    instance_metadata_tags = "enabled"
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-web"
      }
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-ebs"
      }
    )
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-launch-template"
    }
  )
}
