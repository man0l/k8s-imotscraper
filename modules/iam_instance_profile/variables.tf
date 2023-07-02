variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role to associate with the instance profile"
  type        = string
}
