provider "aws" {
  region = "ap-south-1"
  access_key = "***************"
  secret_key = "******************************"

  resource "aws_s3_bucket" "example" {
    bucket = "asdfvcxz"
    acl = "private"
    versioning {
      enabled = true
    }

    tags = {
      Name = "asdfvcxz"
    }
  }
}
