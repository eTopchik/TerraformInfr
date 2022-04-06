variable "cidr"{
  type = string
  default = "10.1.0.0/16"
  description = "Vpc cidr block"
}

variable "az"{
  type = list(string)
  default = ["eu-central-1a","eu-central-1b","eu-central-1c"]
  description = "AvalabilityZones"
}

variable "priv_sub"{
  type = list(string)
  default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
  description = "Private subnets cidr"
}

variable "pub_sub"{
  type = list(string)
  default = ["10.1.4.0/24","10.1.5.0/24","10.1.6.0/24"]
  description = "Public subnets cidr"
}

variable "terraform_remote_state_s3_bucket" {
  type = string
  default = "pmtech-euc1-academy-558280838733-terraform-state"
}

variable "aws_region" {
  type = string
  default = "eu-central-1"
}



