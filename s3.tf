######################################
#                                    #
#       Logging configuration        #
#                                    #
######################################

# Create Bucket
resource "aws_s3_bucket" "logging" {
  bucket        = var.logging_bucket_name
  force_destroy = var.logging_bucket_destroy
}

resource "aws_s3_bucket_acl" "logging_acl" {
  bucket = aws_s3_bucket.logging.id
  acl    = var.logging_bucket_acl
}

resource "aws_s3_bucket_logging" "logging_log" {
  bucket = aws_s3_bucket.logging.id

  target_bucket = aws_s3_bucket.access.id
  target_prefix = var.logging_access_logging_prefix
}

resource "aws_s3_bucket_versioning" "logging_versioning" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status = var.logging_bucket_enable_versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logging_encryption" {
  bucket = aws_s3_bucket.access.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.cloudtrail.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logging_lifecycle" {
  bucket = aws_s3_bucket.logging.id

  rule {
    id = "logging"

    filter {
      prefix = var.logging_access_logging_prefix
    }

    transition {
      days          = var.logging_bucket_backup_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.logging_bucket_backup_expiration_days
    }

    status = var.logging_bucket_enable_backup
  }
}

# Set Public Access Block
resource "aws_s3_bucket_public_access_block" "logging" {
  bucket = aws_s3_bucket.logging.id

  block_public_acls       = var.logging_bucket_block_public_acls
  ignore_public_acls      = var.logging_bucket_ignore_public_acls
  block_public_policy     = var.logging_bucket_block_public_policy
  restrict_public_buckets = var.logging_bucket_restrict_public_buckets
}

data "template_file" "bucket_policy" {
  template = file("${path.module}/files/bucket_policy.tpl.json")
  vars = {
    bucket            = var.logging_bucket_name
    flowlog_folder    = var.flowlogs_bucket_prefix
    cloudtrail_folder = var.cloudtrail_bucket_prefix
  }
}

# Create Bucket Policy
resource "aws_s3_bucket_policy" "logging" {
  bucket = aws_s3_bucket.logging.id
  policy = data.template_file.bucket_policy.rendered

  depends_on = [aws_s3_bucket_public_access_block.logging]
}

######################################
#                                    #
# Access Logging configuration       #
#                                    #
######################################

# Create S3 Bucket
resource "aws_s3_bucket" "access" {
  bucket        = var.access_logging_bucket_name
  force_destroy = var.access_logging_bucket_destroy
}

resource "aws_s3_bucket_acl" "access_acl" {
  bucket = aws_s3_bucket.access.id
  acl    = var.access_logging_bucket_acl
}

resource "aws_s3_bucket_logging" "access_log" {
  bucket = aws_s3_bucket.access.id

  target_bucket = aws_s3_bucket.access.id
  target_prefix = var.access_logging_bucket_name
}

resource "aws_s3_bucket_versioning" "access_versioning" {
  bucket = aws_s3_bucket.access.id
  versioning_configuration {
    status = var.access_logging_bucket_enable_versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "access_encryption" {
  bucket = aws_s3_bucket.access.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "access_ligecycle" {
  bucket = aws_s3_bucket.access.id

  rule {
    id = "access"

    filter {
      prefix = var.access_logging_bucket_name
    }

    transition {
      days          = var.access_logging_bucket_backup_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.access_logging_bucket_backup_expiration_days
    }

    status = var.access_logging_bucket_enable_backup
  }
}

# Set Public Access Block
resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.access.id

  block_public_acls       = var.access_logging_bucket_block_public_acls
  ignore_public_acls      = var.access_logging_bucket_ignore_public_acls
  block_public_policy     = var.access_logging_bucket_block_public_policy
  restrict_public_buckets = var.access_logging_bucket_restrict_public_buckets
}
