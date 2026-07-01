/**
 * ============================================================================
 * SECURITY GROUP
 * ----------------------------------------------------------------------------
 * Allows:
 * - HTTP
 * - HTTPS
 * - SSH
 * ============================================================================
 */

resource "aws_security_group" "web" {
  name        = "mathlab-web-sg"
  description = "Web Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /**
 * Temporary SSH access for development.
 *
 * Recommendation:
 * Replace with AWS Systems Manager Session Manager
 * before production deployment.
 */
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["102.221.201.135/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mathlab-web-sg"
  }
}
