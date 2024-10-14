variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "aws_profile" {
  description = "AWS Credential"
  default     = "tec-aws-profile"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "172.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["172.0.1.0/24", "172.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.0.3.0/24", "172.0.4.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "tec-prod-workloads-1-cluster"
}

variable "node_group_instance_type" {
  description = "EC2 instance type for the EKS node group"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of nodes in the EKS node group"
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of nodes in the EKS node group"
  default     = 3
}

variable "min_capacity" {
  description = "Minimum number of nodes in the EKS node group"
  default     = 1
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for instances"
  type        = string
  default     = "edgeconnect-keypair"
}

