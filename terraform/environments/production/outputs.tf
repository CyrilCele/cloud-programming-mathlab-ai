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

#########################################
# IAM
#########################################

output "ec2_role_name" {
  description = "EC2 IAM Role name."

  value = module.iam.ec2_role_name
}

output "ec2_role_arn" {
  description = "EC2 IAM Role ARN."

  value = module.iam.ec2_role_arn
}

output "instance_profile_name" {
  description = "EC2 Instance Profile name."

  value = module.iam.instance_profile_name
}

output "instance_profile_arn" {
  description = "EC2 Instance Profile ARN."

  value = module.iam.instance_profile_arn
}

#########################################
# S3
#########################################

output "assets_bucket_name" {
  description = "Assets bucket name."

  value = module.s3.bucket_name
}

output "assets_bucket_arn" {
  description = "Assets bucket ARN."

  value = module.s3.bucket_arn
}
