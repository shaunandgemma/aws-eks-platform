variable "aws_region" {
  type        = string
  description = "AWS Region used for the Terraform bootstrap resources"
  default     = "eu-west-2"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI Profile used to assume the project role"
  default     = "aws-eks-platform"
}

variable "state_bucket_name" {
  type        = string
  description = "Amazon S3 globally unique bucket name used for Terraform remote state"
}

variable "project_name" {
  type        = string
  description = "Project name used for the naming and tagging bootstrap resources"
  default     = "aws-eks-platform"
}

variable "environment" {
  type        = string
  description = "Environment name used for tagging bootstrap resources"
  default     = "training"
}

variable "owner" {
  type        = string
  description = "Owner name used for tagging bootstrap resources"
  default     = "shaun"
}

variable "purpose" {
  type        = string
  description = "Purpose used for tagging bootstrap resources"
  default     = "eks-platform-portfolio"
}