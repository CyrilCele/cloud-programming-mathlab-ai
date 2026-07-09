output "certificate_arn" {
  description = "Validate ACM certificate ARN."

  value = aws_acm_certificate_validation.this.certificate_arn
}
