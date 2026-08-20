# Terraform Design

## Terraform Purpose

- Terraform will be the main Infrastructure as Code tool for AWS resources
- Terraform will create, update and destroy the platform infrastructure
- Terraform configuration will be stored in Git so infrastructure changes are version controlled
- Terraform will reduce manual configuration and make the environment repeatable
- Terraform will manage resources such as the VPC, subnets, IAM, ECR, EKS and managed node groups

## File Structure

- versions.tf — Terraform and provider version requirements
- providers.tf — AWS provider configuration
- variables.tf — input variable definitions
- locals.tf — reusable calculated values and common tags
- network.tf — VPC, subnets, routing and NAT resources
- iam.tf — IAM roles and policies
- ecr.tf — ECR repository
- eks.tf — EKS cluster
- nodes.tf — EKS managed node groups
- outputs.tf — useful values produced after deployment

## State Management

- Terraform state will be stored remotely in Amazon S3 rather than as a local state file
- S3 bucket versioning will be enabled so older state versions can be recovered
- S3 state locking will be enabled using Terraform's use_lockfile feature
- State files must never be committed to Git
- Access to the state bucket must follow least privilege
- The state bucket must use encryption
- Backend credentials must not be hard-coded in Terraform files

## Provider Configuration

- Terraform will use the official HashiCorp AWS provider
- AWS resources will be deployed to eu-west-2
- The AWS provider version will be constrained rather than left completely unrestricted
- Authentication will use the standard AWS credential chain, using a named AWS CLI profile where appropriate, rather than hard-coded credentials
- No AWS access keys or secrets will be stored in Terraform files
- Provider configuration will reference variables where appropriate rather than repeating fixed values

## Variables

- Variables will be used for values that may change between environments or deployments
- Variables will include the AWS Region, VPC CIDR, subnet CIDRs, cluster name and node configuration
- Variable types and descriptions will be defined clearly
- Sensible defaults will be used only where appropriate
- Sensitive values must not be hard-coded into variable files
- Validation will be added where useful to prevent invalid input

## Local Values

- Local values will be used for repeated naming patterns and common tags
- A shared resource prefix will be built from the project naming standard
- Common tags will be defined once and reused across supported AWS resources
- Local values will reduce duplicated configuration
- Local values will be used for values derived from variables where appropriate

## Outputs

- Outputs will expose useful deployment information
- Outputs will include the EKS cluster name
- Outputs will include the ECR repository URL
- Outputs will include important VPC and subnet IDs
- Outputs will include values needed by later deployment steps
- Sensitive information must not be exposed unnecessarily through outputs

## Module Strategy

- The first version will use a clear root-module structure so the infrastructure is easy to learn and troubleshoot
- Reusable modules may be introduced after the initial working deployment 
- Modules should group related resources such as networking or EKS where reuse provides real value
- Modules must have clear inputs and outputs
- Over-modularisation should be avoided because it can make a small project harder to understand
- Any external Terraform modules must use pinned versions and be reviewed before use

## Terraform Workflow

- Run terraform fmt to format Terraform code
- Run terraform init to initialise the working directory and providers
- Run terraform validate to check configuration syntax and structure 
- Run terraform plan to review proposed infrastructure changes
- Review the plan before applying anything
- Run terraform apply only after the plan is understood
- Verify deployed resources after apply
- Commit reviewed Terraform changes to Git
- Use terraform destroy only when intentionally tearing down the environment