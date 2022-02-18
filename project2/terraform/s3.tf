
resource "aws_s3_bucket" "van-can" {
   bucket = "van-can"
   force_destroy = true
   #region = var.region
   #acl = "private"
}

/*
resource "aws_dynamodb_table" "terraform-lock" {
    name           = "terraform_state"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}
*/

terraform {
  backend "s3" {
    key            = "terraform.tfstate"
    bucket         = "tfstate-canada"
    region         = "us-east-1"
    #dynamodb_table = "terraform-up-and-running-locks"
    profile = "default"
  }
}

/*
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

*/