# Variables for AWS Credentials
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "This is REGION for our Infrastructure"
}
# Creating DynamoDB to use for locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-locks"
  read_capacity  = 5
  write_capacity = 5
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
