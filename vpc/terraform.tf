terraform {
  #required_version = "1.1.4"
  # Will be filled by Terragrunt
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }
}
