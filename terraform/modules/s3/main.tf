#########################################
# S3 Bucket
#########################################

resource "aws_s3_bucket" "assets" {
  bucket = var.bucket_name

  force_destroy = true

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}

#########################################
# Versioning
#########################################

resource "aws_s3_bucket_versioning" "assets" {
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}

#########################################
# Server-Side Encryption
#########################################

resource "aws_s3_bucket_server_side_encryption_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#########################################
# Public Access Block
#########################################

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

#########################################
# Lifecycle Configuration
#########################################

resource "aws_s3_bucket_lifecycle_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
