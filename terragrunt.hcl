locals {
  aws_region       = "eu-central-1"
  aws_account_id   = "558280838733"
  env              = "academy"
}

remote_state {
  backend = "s3"
  config = {
    bucket = "pmtech-euc1-${local.env}-${local.aws_account_id}-terraform-state"
    s3_bucket_tags = {
      Terragrunt  = "true"
      Student     = "yehor.brilov"
    }
    key            = "${local.aws_region}/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "terraform-${local.env}-lock-state"
    region         = local.aws_region
    dynamodb_table_tags = {
      Terragrunt  = "true"
      Student     = "yehor.brilov"
    }
  }
}

inputs = {
  aws_region             = local.aws_region
  env                    = local.env
  allowed_aws_account_id = local.aws_account_id
  profile                = "aws-${local.env}"
  default_provider_tags = {
    Env          = local.env
    Terraform    = "true"
  }
  terraform_remote_state_s3_bucket      = "pmtech-euc1-${local.env}-${local.aws_account_id}-terraform-state"
  terraform_remote_state_dynamodb_table = "terraform-${local.env}-lock-state"
  terraform_remote_state_file_name      = "terraform.tfstate"
}
