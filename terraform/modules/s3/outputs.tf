output "bucket_name" {
  description = "S3 bucket name."

  value = aws_s3_bucket.assets.bucket
}

output "bucket_id" {
  description = "ID of the S3 bucket."

  value = aws_s3_bucket.assets.id
}

output "bucket_arn" {
  description = "S3 bucket ARN."

  value = aws_s3_bucket.assets.arn
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket."

  value = aws_s3_bucket.assets.bucket_regional_domain_name
}
