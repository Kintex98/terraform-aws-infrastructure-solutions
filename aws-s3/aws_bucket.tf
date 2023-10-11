# aws_s3_bucket.bucket
resource "aws_s3_bucket" "bucket" {
  lifecycle {
    prevent_destroy = true
  }

  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# aws_s3_bucket_versioning.bucket
resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

#aws_s3_bucket_lifecycle_configuration.bucket
resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  depends_on = [aws_s3_bucket_versioning.bucket]

  bucket = aws_s3_bucket.bucket.bucket

  rule {
    id     = "ClearOldVersions"
    status = "Enabled"

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      newer_noncurrent_versions = 6
      noncurrent_days           = 90
    }
  }
}
