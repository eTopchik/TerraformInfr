output vpc_id {
  value       = module.vpc.vpc_id
  description = "Vpc id "
}

output vpc_cidr {
  value       = module.vpc.vpc_cidr_block
  description = "Vpc cidr block"
}

output priv_subnet_id {
  value       = module.vpc.private_subnets
  description = "List of private subnet id's"

}
