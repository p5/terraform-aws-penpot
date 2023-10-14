resource "aws_s3_bucket" "this" {
  bucket = var.name
}

resource "aws_s3_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "Delete old versions"
    status = "Enabled"

    filter {
      prefix = "/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
