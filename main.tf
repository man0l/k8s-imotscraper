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

module "iam_role_policy_attachment" {
  source = "./modules/iam_role_policy_attachment"

  role_name = module.iam_role.role_name
  policy_arn = module.iam_policy.policy_arn
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
