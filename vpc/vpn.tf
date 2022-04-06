locals {
  student_id = "ybrilov"
}

module "ec2_client_vpn" {
  source  = "cloudposse/ec2-client-vpn/aws"
  version = "0.10.8"

  client_cidr         = "10.101.0.0/16"
  organization_name   = local.student_id
  ca_common_name      = "${local.student_id}.vpn.ca"
  root_common_name    = "${local.student_id}.vpn.client"
  server_common_name  = "${local.student_id}.vpn.server"
  logging_enabled     = false
  retention_in_days   = 0
  associated_subnets  = module.vpc.private_subnets
  authorization_rules = []
  logging_stream_name = local.student_id
  vpc_id              = module.vpc.vpc_id
  additional_routes = [
    {
      destination_cidr_block = "0.0.0.0/0"
      description            = "Internet Route"
      target_vpc_subnet_id   = element(module.vpc.private_subnets, 0)
    }
  ]
}