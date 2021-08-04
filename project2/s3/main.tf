provider "aws" {
	region = var.aws_region
}

resource "aws_s3_bucket" "a" {
  bucket = "tl-incidents2"
	acl = var.acl

	versioning {
	  enabled = var.versioning
	}

	tags = var.tags
}
