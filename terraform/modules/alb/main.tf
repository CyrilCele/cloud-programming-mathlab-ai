#########################################
# Target Group
#########################################

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

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}
