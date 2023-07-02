variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "subnets" {
  description = "List of subnets to use for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be created"
  type        = string
}

variable "desired_capacity" {
  description = "Number of instances to launch in the EKS node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of instances in the EKS node group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of instances in the EKS node group"
  type        = number
}

variable "instance_types" {
  description = "Instance type to use for the EKS node group"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type to use for the EKS node group either SPOT or ON_DEMAND"
  type        = string
}

variable "key_name" {
  description = "Key pair name to use for the EKS node group"
  type        = string
}

variable "environment" {
  description = "Environment tag and label to apply to resources"
  type        = string
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap"
  type        = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap"
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap"
  type        = list(string)
  default     = []
}
