output "vpc_id" {
  description = "ID of the provisioned VPC."

  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."

  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."

  value = module.networking.private_subnet_ids
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway."

  value = module.networking.nat_gateway_id
}

output "alb_security_group_id" {
  description = "ID of the Application Load Balancer security group."

  value = module.security_groups.alb_security_group_id
}

output "ec2_security_group_id" {
  description = "ID of the EC2 instance security group."

  value = module.security_groups.ec2_security_group_id
}
