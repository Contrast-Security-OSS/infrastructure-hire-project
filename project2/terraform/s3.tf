
resource "aws_s3_bucket" "vancouver-canada" {
   bucket = var.s3bucket
   force_destroy = true
   #region = var.region
}

