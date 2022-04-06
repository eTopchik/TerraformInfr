resource "tls_private_key" "ec2_keypair" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "tfkey"
  public_key = tls_private_key.ec2_keypair.public_key_openssh
}
# Security group for SSHing to EC2 instances
module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-vpc"
  description = "Security group for web-server with SSH ports open within client VPN VPC"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr]

  computed_egress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.vpc_cidr
    }
  ]

  number_of_computed_egress_with_cidr_blocks = 1
}


# EC2 instances
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(data.terraform_remote_state.vpc.outputs.priv_subnet_id)

  name = "instance-${each.key}"

  ami                    = "ami-0d527b8c289b4af7f" # this should be taken from aws_ami datasource
  instance_type          = "t3.micro"
  key_name               = module.key_pair.key_pair_key_name
  monitoring             = false
  vpc_security_group_ids = [module.ssh_sg.security_group_id]
  subnet_id              = each.key
  user_data = <<-EOT
  #!/bin/bash
  sudo apt install nginx
  sudo chmod 0755 /var/www/html
  cat /dev/null > /var/www/html/index && echo '<h1>Terraform configured page</h1>' > /var/www/html/index.html
  EOT
}