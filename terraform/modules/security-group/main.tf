###########################################
# Application Load Balancer Security Group
###########################################

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for the Application Load Balancer."
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-alb-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "alb_http_from_cloudfront" {
  security_group_id = aws_security_group.alb.id

  description = "Allow HTTP only from AWS CloudFront origin-facing infrastructure."

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  prefix_list_id = var.cloudfront_origin_prefix_list_id
}

resource "aws_vpc_security_group_egress_rule" "alb_outbound" {
  security_group_id = aws_security_group.alb.id

  description = "Allow outbound traffic from the Application Load Balancer."

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

#########################################
# EC2 Security Group
#########################################

resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for EC2 instances."
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http_from_alb" {
  security_group_id = aws_security_group.ec2.id

  description = "Allow HTTP traffic from the Application Load Balancer."

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "ec2_outbound" {
  security_group_id = aws_security_group.ec2.id

  description = "Allow outbound traffic from EC2 instances through the NAT Gateway."

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
