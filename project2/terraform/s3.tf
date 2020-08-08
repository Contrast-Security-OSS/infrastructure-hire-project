##############################################################
#  Vulnerability reporting bucket
##############################################################
resource "aws_s3_bucket" "vulnerability_reporting" {
  bucket = "${var.project}-vulnerability-reporting"
  policy = data.aws_iam_policy_document.vulnerability_reporting.json

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.infra.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    name      = "${var.project}-vulnerability-reporting"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}

# S3 bucket policy
data "aws_iam_policy_document" "vulnerability_reporting" {

  # Deny incorrect encryption key
  statement {
    sid       = "DenyIncorrectEncryption"
    effect    = "Deny"
    actions   = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.project}-vulnerability-reporting/*"
    ]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotLikeIfExists"
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
      values   = [aws_kms_key.infra.arn]
    }
  }

  # Deny unencrypted object uploads
  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.project}-vulnerability-reporting/*"
    ]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}
