output "hosted_zone_id" {
  description = "Hosted Zone ID."

  value = aws_route53_zone.this.zone_id
}

output "zone_name" {
  description = "Hosted Zone name."

  value = aws_route53_zone.this.name
}

output "name_servers" {
  description = "Authoritative Route53 Name Servers."

  value = aws_route53_zone.this.name_servers
}
