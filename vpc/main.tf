module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tfvpc"
  cidr = var.cidr

  azs             = var.az
  private_subnets = var.priv_sub
  public_subnets  = var.pub_sub

  enable_nat_gateway = true
  enable_vpn_gateway = true
}