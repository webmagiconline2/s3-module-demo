resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = var.acl

  region                 = var.region

  tags = var.tags

  versioning {
    enabled = var.versioning
  }

  logging {
    target_bucket = var.logging.target_bucket
    target_prefix = var.logging.target_prefix
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      id       = lifecycle_rule.id
      prefix   = lifecycle_rule.prefix
      tags     = lifecycle_rule.tags
      enabled  = lifecycle_rule.enabled

      dynamic "transition" {
        for_each = lifecycle_rule.transitions
        content {
          days        = transition.days
          storage_class = transition.storage_class
        }
      }
    }
  }
}
