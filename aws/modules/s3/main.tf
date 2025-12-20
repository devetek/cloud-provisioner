resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(
    {
      Name = var.bucket_name
    },
    var.tags
  )
}
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

# Enable when Terraform AWS provider supports aws_s3_bucket_server_side_encryption_configuration
# TODO: Make it optional based on var.server_side_encryption_enabled
# resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
#   bucket = aws_s3_bucket.this.id

#   dynamic "rule" {
#     for_each = var.server_side_encryption_enabled ? [1] : []

#     content {
#       apply_server_side_encryption_by_default {
#         sse_algorithm     = var.sse_algorithm
#         kms_master_key_id = var.kms_master_key_id
#       }
#     }
#   }
# }
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.public_access_block
  block_public_policy     = var.public_access_block
  ignore_public_acls      = var.public_access_block
  restrict_public_buckets = var.public_access_block
}
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      noncurrent_version_expiration {
        noncurrent_days = rule.value.noncurrent_days
      }
    }
  }
}
