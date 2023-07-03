variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
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
