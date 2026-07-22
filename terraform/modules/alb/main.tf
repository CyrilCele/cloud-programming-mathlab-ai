#########################################
# Target Group
#########################################

#checkov:skip=CKV_AWS_378:TLS terminates at CloudFront; the CloudFront-to-ALB and ALB-to-instance migration to TLS requires ACM certificates and HTTPS listeners on the origin tier.
resource "aws_lb_target_group" "this" {
  name                 = "${var.project_name}-tg"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "instance"
  deregistration_delay = 30
  protocol_version     = "HTTP1"
  vpc_id               = var.vpc_id

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
    matcher  = "200"

    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-tg"
    }
  )
}

#########################################
# Application Load Balancer
#########################################

#checkov:skip=CKV2_AWS_20:Viewer HTTP-to-HTTPS redirection is enforced by CloudFront; the ALB accepts only CloudFront origin-facing traffic.
#checkov:skip=CKV2_AWS_28:The public ALB is restricted to the AWS-managed CloudFront origin-facing prefix list and is protected by the CloudFront-associated WAF.
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.security_group_id
  ]

  subnets                    = var.public_subnet_ids
  idle_timeout               = 60
  enable_deletion_protection = var.enable_deletion_protection
  drop_invalid_header_fields = true

  access_logs {
    bucket  = var.access_logs_bucket_name
    prefix  = var.access_logs_bucket_prefix
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-alb"
    }
  )
}

#########################################
# HTTP Listener
#########################################

#checkov:skip=CKV_AWS_2:TLS terminates at CloudFront; origin TLS requires a separately governed ALB certificate and HTTPS listener migration.
#checkov:skip=CKV_AWS_103:This listener is intentionally HTTP-only behind CloudFront and therefore has no applicable TLS security policy.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}
