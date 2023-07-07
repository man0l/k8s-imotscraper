module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.subnets
  vpc_id = var.vpc_id

  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  eks_managed_node_groups = {
    node_group_1 = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity

      instance_types = var.instance_types
      capacity_type = "${var.capacity_type}"  # Add this line to use Spot instances

     
      additional_tags = {
        Environment = var.environment
        Name        = "${var.cluster_name}-worker-node"
      }

      k8s_labels = {
        Environment = var.environment
        Role        = "worker-node"
      }
    }
  }

  #map_roles    = var.map_roles
  #map_users    = var.map_users
  #map_accounts = var.map_accounts

  #manage_aws_auth = true
}

#################### KMS Key ########################

module "kms" {
  source  = "terraform-aws-modules/kms/aws"

  aliases               = ["eks/${var.cluster_name}"]
  description           = "${var.cluster_name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]
  key_administrators = ["arn:aws:iam::362138392771:user/github-workflow-actions-ci-cd", "arn:aws:iam::362138392771:user/sivakumar"]
  key_users          = ["arn:aws:iam::362138392771:user/github-workflow-actions-ci-cd", "arn:aws:iam::362138392771:user/sivakumar"]

  tags = {
    Environment = "${var.environment}"
  }
}

data "aws_caller_identity" "current" {}
