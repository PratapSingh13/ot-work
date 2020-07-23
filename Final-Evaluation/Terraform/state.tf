# Adding backend configuration
terraform {
  backend "s3" {
    bucket = "final-tf-state"
    key    = "terraform"
    region = "ap-south-1"
    # Replacing this with DynamoDB table name
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
