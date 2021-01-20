provider "aws" {

 region = var.region
}

module "mediawiki_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "mediawiki"
  description = "Security group for user-service for mediawiki for custom ports"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
	from_port = 22
	to_port   = 22
	protocol  = "tcp"
	description = "ssh-config"
	cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9200
      to_port     = 9300
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "172.31.0.0/16"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = var.name
  instance_count         = var.instance_count
  ami                    = var.ami 
  instance_type          = var.instance_type 
  key_name               = var.key_name 
  monitoring             = true
  vpc_security_group_ids = ["${module.mediawiki_sg.this_security_group_id}"]
  subnet_id              = var.subnet_id

tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
