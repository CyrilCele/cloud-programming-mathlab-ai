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

output "kms_key_arn" {
  description = "ARN of the KMS key protecting the assets bucket."

  value = aws_kms_key.assets.arn
}

output "kms_key_id" {
  description = "ID of the KMS key protecting the assets bucket."

  value = aws_kms_key.assets.key_id
}

output "website_object_hash" {
  description = "Hash of the deployed website archive."
  value       = filemd5(var.website_zip_path)
}

output "website_object_version_id" {
  description = "S3 version ID of the uploaded website deployment archive."
  value       = aws_s3_object.website.version_id
}
