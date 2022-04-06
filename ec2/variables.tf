variable "aws_region" {
  type = string
  default = "eu-central-1"
}


# variable "profile" {}
variable "terraform_remote_state_s3_bucket" {
  type = string
  default = "pmtech-euc1-academy-558280838733-terraform-state"
}