region = "eu-central-1"

name = "scraper-vpc"
cidr = "10.0.0.0/16"

azs = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

role_name = "scraper-eks-role"
policy_name = "scraper-eks-policy"
instance_profile_name = "scraper-eks-instance-profile"

sg_name = "scraper-eks-sg"
sg_description = "Security group for EKS cluster"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
from_port_https = 443
to_port_https = 443

lt_name = "scraper-eks-lt"
image_id = "ami-0c94855f1c0118b6"
instance_types = ["t2.micro", "t3.micro", "t3a.micro", "t2.small", "t3.small", "t3a.small", "t2.medium", "t3.medium", "t3a.medium", "t2.large", "t3.large", "t3a.large"]
key_name = "scraper-key-pair"
user_data = "#!/bin/bash\necho 'Hello, World!' > /var/www/html/index.html"
tags = { Name = "EKS-Launch-Template", Environment = "dev" }

cluster_name    = "scraper-eks-cluster"
cluster_version = "1.27"

desired_capacity = 2
max_capacity     = 2
min_capacity     = 1
capacity_type    = "SPOT"

environment   = "dev"
public_key_path    = "~/.ssh/id_rsa.pub"
public_key         = ""

ec2_instance_name = "jump-box"
ec2_instance_type = "t2.micro"

