variable "aws_region" {
  type        = string
  description = "AWS Region used for the EKS platform"
  default     = "eu-west-2"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile used to assume the EKS project role"
  default     = "aws-eks-platform"
}

variable "project_name" {
  type        = string
  description = "Project name used for naming and tagging AWS resources"
  default     = "aws-eks-platform"
}

variable "environment" {
  type        = string
  description = "Environment used for tagging AWS resources"
  default     = "training"
}

variable "owner" {
  type        = string
  description = "Owner name used for tagging AWS resources"
  default     = "shaun"
}

variable "purpose" {
  type        = string
  description = "Purpose used for tagging AWS resources"
  default     = "eks-platform-portfolio"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block used for the EKS platform VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the public subnet in eu-west-2a"
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the public subnet in eu-west-2b"
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the private subnet in eu-west-2a"
  default     = "10.0.10.0/24"
}

variable "private_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the private subnet in eu-west-2b"
  default     = "10.0.20.0/24"
}

variable "availability_zone_a" {
  type        = string
  description = "Primary Availability Zone for the EKS platform"
  default     = "eu-west-2a"
}

variable "availability_zone_b" {
  type        = string
  description = "Secondary Availability Zone for the EKS platform"
  default     = "eu-west-2b"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Amazon EKS cluster"
  default     = "aws-eks-platform-cluster"
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type used by the EKS managed node group"
  default     = "t3.medium"
}

variable "node_min_size" {
  type        = number
  description = "Minimum number of worker nodes in the EKS managed node group"
  default     = 2
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of worker nodes in the EKS managed node group"
  default     = 2
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of worker nodes in the EKS managed node group"
  default     = 4
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version used by the Amazon EKS cluster"
  default     = "1.36"
}

