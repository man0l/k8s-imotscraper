# Imot Scraper
This repository spins up elastic kubernetes service (EKS) in the AWS cloud. It uses spot instances to spin up the cluster. The cluster is deployed using terraform. 

## AWS EKS infrastructure running on SPOT instances
The repository contains the infrastructure code for the AWS EKS cluster. The infrastructure is deployed using Terraform. The infrastructure is deployed to the AWS region specified in the `terraform.tfvars` file. 

The infrastructure is deployed in the following order:
1. VPC
2. EKS cluster
3. EKS node group
4. EKS node group autoscaling group
5. EKS node group security group
6. EKS node group IAM role
7. EKS node group IAM role policy
8. EKS node group IAM instance profile

## Prerequisites
1. Terraform 0.12.24
2. AWS CLI
3. AWS IAM Authenticator
4. kubectl
5. public ssh key located in ~/.ssh/id_rsa.pub

## Deployment
1. Clone the repository
2. Create a new file called `terraform.tfvars` in the root of the repository
3. Add the following variables to the `terraform.tfvars` file:

| Variable | Description |
| --- | --- |
| aws_region | The AWS region to deploy the infrastructure to |
| aws_access_key | The AWS access key |
| aws_secret_key | The AWS secret key |
| cluster_name | The name of the EKS cluster |
| cluster_version | The version of the EKS cluster |
| cluster_subnet_ids | The subnet IDs to deploy the EKS cluster to |
| cluster_security_group_id | The security group ID to deploy the EKS cluster to |
| node_group_name | The name of the EKS node group |
| node_group_instance_type | The instance type of the EKS node group |
| node_group_desired_capacity | The desired capacity of the EKS node group |
| node_group_min_size | The minimum size of the EKS node group |
| node_group_max_size | The maximum size of the EKS node group |
| node_group_subnet_ids | The subnet IDs to deploy the EKS node group to |
| node_group_security_group_id | The security group ID to deploy the EKS node group to |
| node_group_key_name | The key name to deploy the EKS node group to |

4. Run `terraform init` to initialize the Terraform configuration
5. Run `terraform plan` to view the Terraform execution plan
6. Run `terraform apply` to apply the Terraform configuration

## Outputs
| Output | Description |
| --- | --- |
| cluster_name | The name of the EKS cluster |
| cluster_endpoint | The endpoint of the EKS cluster |
| cluster_certificate_authority_data | The certificate authority data of the EKS cluster |
| cluster_security_group_id | The security group ID of the EKS cluster |
| node_group_name | The name of the EKS node group |
| node_group_arn | The ARN of the EKS node group |
| node_group_security_group_id | The security group ID of the EKS node group |
| node_group_iam_role_arn | The ARN of the IAM role of the EKS node group |
| node_group_iam_role_name | The name of the IAM role of the EKS node group |
| node_group_iam_instance_profile_arn | The ARN of the IAM instance profile of the EKS node group |
| node_group_iam_instance_profile_name | The name of the IAM instance profile of the EKS node group |
| node_group_iam_role_policy_arn | The ARN of the IAM role policy of the EKS node group |
| node_group_iam_role_policy_name | The name of the IAM role policy of the EKS node group |

## Destroy

1. Run `terraform destroy` to destroy the Terraform configuration

