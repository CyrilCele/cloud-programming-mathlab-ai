output "alb_id" {
  description = "Application Load Balancer ID."

  value = aws_lb.this.id
}

output "alb_arn" {
  description = "Application Load Balancer ARN."

  value = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name."

  value = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Hosted Zone ID of the Application Load Balancer."

  value = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "Application Load Balancer Target Group ARN."

  value = aws_lb_target_group.this.arn
}

output "alb_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer."

  value = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  description = "ARN suffix of the Target Group."

  value = aws_lb_target_group.this.arn_suffix
}
