# Route 53 Hosted Zone Module

## Overview

The Route 53 Hosted Zone module provisions a public Amazon Route 53 Hosted Zone for the MathLab AI Infrastructure.

The hosted zone provides authoritative DNS management for the application's domain and enables seamless integration with AWS services such as AWS Certificate Manager (ACM), Amazon CloudFront, and Route 53 DNS records.

The hosted zone serves as the foundation of the project's DNS architecture and allows all DNS records to be managed through Infrastructure as Code (IaC).

---

# Features

- Creates a public Route 53 Hosted Zone
- Provides authoritative DNS management
- Generates AWS Name Servers
- Supports ACM DNS validation
- Supports CloudFront alias records
- Enables Infrastructure as Code for DNS
- Applies consistent resource tagging

---

# Resources Created

| Resource                    | Purpose                                        |
| --------------------------- | ---------------------------------------------- |
| Route 53 Public Hosted Zone | Hosts authoritative DNS records for the domain |

---

# Architecture

```
                    Internet
                        │
                        ▼
             Route 53 Hosted Zone
                        │
        ┌───────────────┼────────────────┐
        ▼               ▼                ▼
 ACM Validation     CloudFront      Future Records
     Records        Alias Records   (MX, TXT, etc.)
```

The hosted zone becomes the central DNS authority for the application's AWS-managed records.

---

# Hosted Zone

The module creates a public hosted zone for:

```
mathlab-ai.publicvm.com
```

AWS automatically assigns four authoritative name servers.

Example:

```
ns-xxxx.awsdns-xx.com
ns-xxxx.awsdns-xx.net
ns-xxxx.awsdns-xx.org
ns-xxxx.awsdns-xx.co.uk
```

These name servers are used when delegating the subdomain from the parent DNS provider.

---

# DNS Delegation

The deployment uses **subdomain delegation**.

```
publicvm.com
        │
        ▼
mathlab-ai.publicvm.com
        │
        ▼
Amazon Route 53
```

The parent DNS provider delegates authority for the subdomain by creating NS records that point to the Route 53 name servers.

Once delegated, Route 53 becomes authoritative for all records under:

```
mathlab-ai.publicvm.com
```

---

# Inputs

| Name        | Description                 | Type        | Required |
| ----------- | --------------------------- | ----------- | -------- |
| domain_name | Fully qualified domain name | string      | Yes      |
| tags        | Common resource tags        | map(string) | Yes      |

---

# Outputs

| Output         | Description                         |
| -------------- | ----------------------------------- |
| hosted_zone_id | Route 53 Hosted Zone ID             |
| zone_name      | Hosted Zone name                    |
| name_servers   | Route 53 authoritative name servers |

---

# Dependencies

This module has no infrastructure dependencies.

Its outputs are consumed by:

- ACM Module
- Route 53 Records Module
- Production Environment

---

# Example Usage

```hcl
module "route53_zone" {
  source = "../../modules/route53-zone"

  domain_name = var.domain_name

  tags = local.common_tags
}
```

---

# Integration

The hosted zone integrates directly with:

- AWS Certificate Manager (DNS validation)
- Amazon CloudFront
- Route 53 Alias Records
- Future email authentication records (SPF, DKIM, DMARC)
- Additional application subdomains

---

# Security

Although DNS is publicly accessible by design, Route 53 contributes to a secure architecture by:

- Providing authoritative DNS management
- Supporting DNS validation for ACM certificates
- Enabling Alias Records instead of exposing origin endpoints
- Eliminating manual DNS configuration drift through Terraform

---

# Operational Notes

After deployment:

1. Terraform creates the hosted zone.
2. AWS assigns four authoritative name servers.
3. The parent DNS provider delegates the subdomain to those name servers.
4. Route 53 becomes authoritative for the subdomain.
5. ACM DNS validation succeeds automatically.
6. CloudFront becomes reachable through the custom domain.

---

# Maintenance

When updating this module:

- Verify the domain name.
- Confirm hosted zone delegation.
- Ensure name servers remain correctly configured.
- Execute `terraform validate`.
- Review the Terraform execution plan before deployment.

---

# Future Enhancements

Possible future improvements include:

- DNSSEC
- Health Checks
- Failover Routing
- Geolocation Routing
- Latency-Based Routing
- Weighted Routing
- Multi-Region Disaster Recovery

These features can be incorporated as the infrastructure evolves.

---

# Troubleshooting

## Domain does not resolve

Verify:

- The parent DNS provider has delegated the subdomain.
- The Route 53 name servers are correct.
- DNS propagation has completed.

---

## ACM validation fails

Verify:

- The hosted zone is authoritative.
- DNS validation records exist.
- The parent NS delegation is correct.

---

## CloudFront cannot resolve the domain

Verify:

- Alias records exist.
- Hosted zone delegation is complete.
- CloudFront distribution has finished deploying.

---

# Conclusion

The Route 53 Hosted Zone module establishes the DNS foundation of the MathLab AI Infrastructure. By providing authoritative DNS management, seamless integration with AWS services, and Infrastructure as Code, it enables secure, scalable, and maintainable domain management suitable for production cloud environments.
