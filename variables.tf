variable "region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
}

variable "from_port" {
  description = "Start port for the ingress rule"
  type        = number
}

variable "to_port" {
  description = "End port for the ingress rule"
  type        = number
}

variable "from_port_https" {
  description = "Start port for the ingress rule"
  type        = number
}

variable "to_port_https" {
  description = "End port for the ingress rule"
  type        = number
}

variable "protocol" {
  description = "Protocol for the ingress rule"
  type        = string
}

variable "cidr_blocks" {
  description = "CIDR blocks for the ingress rule"
  type        = list(string)
}

variable "lt_name" {
  description = "Name of the launch template"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the launch template"
  type        = string
}

variable "instance_types" {
  description = "Instance type for the launch template"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type for the launch template either SPOT or ON_DEMAND"
  type        = string
}

variable "user_data" {
  description = "User data script for the launch template"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources created by the launch template"
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "environment" {
  description = "Environment tag to apply to resources"
  type        = string
}



variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "jump-box"
}

variable "ec2_instance_type" {
  description = "Type of the jump-box EC2 instance"
  type        = string
  default     = "t2.micro"
}
