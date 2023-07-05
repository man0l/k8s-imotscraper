provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Environment = var.environment
  }
}

module "iam_role" {
  source = "./modules/iam_role"

  role_name = var.role_name
  policy_arn = module.iam_policy.policy_arn
}


module "iam_policy" {
  source = "./modules/iam_policy"

  policy_name = var.policy_name
}

module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"

  instance_profile_name = var.instance_profile_name
  role_name = module.iam_role.role_name
}

module "security_group" {
  source = "./modules/security_group"

  sg_name = var.sg_name
  sg_description = var.sg_description
  vpc_id = module.vpc.vpc_id
  from_port = var.from_port
  to_port = var.to_port
  from_port_https = var.from_port_https
  to_port_https = var.to_port_https
  protocol = var.protocol
  cidr_blocks = var.cidr_blocks
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  desired_capacity = var.desired_capacity
  max_capacity     = var.max_capacity
  min_capacity     = var.min_capacity

  instance_types = var.instance_types
  capacity_type = var.capacity_type
  key_name      = var.key_name
  environment   = var.environment

  map_roles = [
    {
      rolearn  = module.iam_role.role_arn
      username = var.role_name
      groups   = ["system:masters"]
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "scraper-key-pair"
  public_key = fileexists(var.public_key_path) ? file(var.public_key_path) : var.public_key
}

terraform {
  backend "s3" {
    bucket = "eks-terraform-imot-scraper-state"
    key    = "dev/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}

#########################################################
################ JUMP-BOX ###############################
#########################################################

############## Keypair for jump-box #######################

resource "aws_key_pair" "jump-box" {
  key_name   = "jump-box-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#### local_file resource store private key in the root folder ########

resource "local_file" "key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "jumpbox-key"
}

################# EC2 instance for jump-box ##############

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_instance_name

  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.jump-box.key_name
  monitoring             = true
  vpc_security_group_ids = [module.security_group_ec2.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  disable_api_termination = true

  depends_on = [
    module.vpc
  ]
  tags = {
    Environment = var.environment
  }
}

############# security group for jump-box ###################
module "security_group_ec2" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.name}-jump-box-sg"
  description = "jump-box security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow ssh access witin VPC"
      cidr_blocks = var.cidr
    },
  ]
  egress_cidr_blocks = ["0.0.0.0/0"]
  depends_on = [
    module.vpc
  ]

  tags = {
    Environment = var.environment
  }


}


################### SG rule for jump-box ###############################

resource "aws_security_group_rule" "jump-sg" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.cidr]
  security_group_id = module.eks.cluster_security_group_id
}
