# Providing the AWS Credentials
provider "aws" {
    profile    = "default"
    region     = var.region
    version    = "~> 2.12.0"
}
