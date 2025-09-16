# S3 Module - Main Configuration
# Creates S3 buckets with security best practices

# Random suffix for bucket uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.environment}-${var.bucket_purpose}-${random_id.bucket_suffix.hex}"

  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-${var.bucket_purpose}"
    Environment = var.environment
    Purpose     = var.bucket_purpose
  })
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

# S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enable_encryption ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = var.kms_key_id != null ? "aws:kms" : "AES256"
    }
    bucket_key_enabled = var.kms_key_id != null ? true : false
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}

# S3 Bucket Lifecycle Configuration
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.lifecycle_enabled ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "${var.bucket_purpose}-lifecycle"
    status = "Enabled"

    filter {
      prefix = var.lifecycle_prefix
    }

    dynamic "expiration" {
      for_each = var.expiration_days > 0 ? [1] : []
      content {
        days = var.expiration_days
      }
    }

    dynamic "noncurrent_version_expiration" {
      for_each = var.noncurrent_version_expiration_days > 0 ? [1] : []
      content {
        noncurrent_days = var.noncurrent_version_expiration_days
      }
    }

    dynamic "abort_incomplete_multipart_upload" {
      for_each = var.abort_incomplete_multipart_upload_days > 0 ? [1] : []
      content {
        days_after_initiation = var.abort_incomplete_multipart_upload_days
      }
    }
  }
}

# S3 Bucket Policy (optional)
resource "aws_s3_bucket_policy" "this" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}
