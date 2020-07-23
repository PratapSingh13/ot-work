# Providing the AWS Credentials
provider "aws" {
    profile    = "default"
    region     = var.region
    version    = "~> 2.12.0"
}

# Creating S3 bucket for saving TF state file
resource "aws_s3_bucket" "final_tf_state_bucket" {
  bucket = "final-tf-state"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
