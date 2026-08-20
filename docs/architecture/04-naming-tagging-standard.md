# Naming and Tagging Standard

## Resource Prefix

- aws-eks-platform

## Naming Format

- Use lowercase names
- Use hyphens between words
- Start resource name with aws-eks-platform
- End the resource name with the resource type or purpose
- Keep names consistent across Terraform and AWS

## Required Tags

- Project = aws-eks-platform
- Environment = training
- ManagedBy = Terraform
- Owner = shaun
- Purpose = eks-platform-portfolio

## Naming Examples

- VPC -> aws-eks-platform-vpc
- Public subnet A -> aws-eks-platform-public-a
- Public subnet B -> aws-eks-platform-public-b
- Private subnet A -> aws-eks-platform-private-a
- Private subnet B -> aws-eks-platform-private-b
- EKS cluster -> aws-eks-platform-cluster
- ECR repository -> aws-eks-platform-ecr
- Node group -> aws-eks-platform-node-group
- ALB -> aws-eks-platform-alb