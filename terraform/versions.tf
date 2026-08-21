terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "aws-eks-platform-tfstate-406760143388"
    key          = "eks-platform/terraform.tfstate"
    region       = "eu-west-2"
    profile      = "aws-eks-platform"
    encrypt      = true
    use_lockfile = true
  }
}