output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group" {
  description = "Security group ID attached to the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster."
  value       = module.eks.cluster_iam_role_name
}

output "vpc_subnets" {
  description = "VPC public subnet IDs"
  value       = module.vpc.public_subnets
}
