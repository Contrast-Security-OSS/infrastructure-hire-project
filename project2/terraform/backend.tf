terraform {
  backend "s3" {
    bucket = "project2-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
