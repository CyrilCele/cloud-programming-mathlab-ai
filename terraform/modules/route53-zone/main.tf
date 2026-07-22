#########################################
# Public Hosted Zone
#########################################

#checkov:skip=CKV2_AWS_38:DNSSEC requires coordinated KMS, Route 53 key-signing, registrar DS publication, rotation, monitoring, and rollback procedures; it is deferred to a dedicated DNSSEC migration.
#checkov:skip=CKV2_AWS_39:Route 53 query logging requires a defined us-east-1 CloudWatch logging architecture, retention policy, alerting consumer, and cost approval.
resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = merge(
    var.tags,
    {
      Name = var.domain_name
    }
  )
}
