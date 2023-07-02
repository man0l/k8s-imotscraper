module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.subnets
  vpc_id = var.vpc_id

  eks_managed_node_groups = {
    node_group_1 = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity

      instance_types = var.instance_types
      capacity_type = "${var.capacity_type}"  # Add this line to use Spot instances

      key_name      = var.key_name
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
