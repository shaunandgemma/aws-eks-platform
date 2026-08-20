# Architecture Design

## Architecture Overview

- AWS will host the platform
- Terraform will create the AWS infrastructure
- EKS will run the Kubernetes cluster
- Managed worker nodes will run the application Pods
- Docker images will be stored in ECR
- Helm will manage application deployment 
- An ALB will provide public access
- CloudWatch will provide monitoring and logs
- The design will span multiple Availability Zones

## Network Design

- Use one dedicated VPC
- Use two Availability Zones in eu-west-2
- Create public subnets in both Availability Zones
- Create private subnets in both Availability Zones
- Place the ALB in the public subnets
- Place EKS worker nodes in the private subnets
- Use an Internet Gateway for public internet access
- Use NAT Gateway(s) access so private worker nodes can reach required internet services without being publicly reachable
- Use route tables to control subnet traffic
- Use security groups to restrict traffic between components

## EKS Design

- Amazon EKS will provide the Kubernetes control plane
- EKS managed node groups will provide worker compute
- Worker nodes will run in private subnets
- The cluster will span multiple Availability Zones
- Kubernetes Deployments will manage application Pods
- Kubernetes Services will provide stable access to Pods
- Kubernetes Ingress will route external traffic into the application
- EKS Pod Identity will provide AWS permissions to workloads
- Kubernetes Horizontal Pod Autoscaler will scale application Pods when needed

## Container Design

- The application will be packaged as a Docker container image
- The Docker image will contain only the files and dependencies required to run the application
- Container images will be stored in Amazon ECR
- Images will use version tags so releases can be identified and rolled back
- Containers will not contain AWS credentials or hard-coded secrets
- Application configuration will be supplied externally through Kubernetes
- Containers should run as a non-root user where possible
- The container must expose a health endpoint for Kubernetes health checks

## Traffic Flow

- Users send requests to the public Application Load Balancer
- The ALB forwards traffic to the Kubernetes Ingress
- The Ingress routes traffic to the correct Kubernetes Service
- The Kubernetes Service forwards traffic to healthy application Pods
- Pods send responses back through the same path
- Health checks ensure traffic is only sent to healthy workloads
- EKS worker nodes remain private and are not directly exposed to the internet

## IAM and Security Design

- IAM permissions will follow least privilege 
- EKS workloads that need AWS access will use EKS Pod Identity
- Long-lived AWS access keys will not be stored in Pods
- EKS cluster access will be controlled using EKS access entries and IAM roles
- Kubernetes RBAC will restrict what users and service accounts can do
- Worker nodes will remain in private subnets
- Security groups will only allow required network traffic
- Containers should run as non-root where possible
- Secrets will not be hard-coded into source code or container images
- AWS and Kubernetes activity will be logged for auditing and troubleshooting

## Scaling Design

- Kubernetes Horizontal Pod Autoscaler will scale application Pods based on resource demand
- CPU and memory requests and limits will be defined so scaling decisions have useful data
- EKS managed node groups will have minimum, desired and maximum node counts
- Kubernetes Cluster Autoscaler will increase worker-node capacity when Pods cannot be scheduled
- Cluster Autoscaler will reduce worker-node capacity when nodes are no longer required
- Scaling limits will prevent uncontrolled resource growth and unnecessary cost
- Application replicas will be spread across multiple Availability Zones where possible

## Monitoring Design

- CloudWatch will collect EKS and application logs
- CloudWatch metrics will monitor CPU, memory and general platform health
- Pod and node health will be monitored
- Application Load Balancer health and request behaviour will be monitored
- Alerts will notify us of important failures or unhealthy conditions
- Monitoring data will be used for troubleshooting and incident investigation
- Prometheus and Grafana may be added later for deeper Kubernetes monitoring

## Deployment Design

- Terraform will provision and update AWS infrastructure
- Application source code will be stored in Git and GitHub
- Docker will build versioned application images
- Amazon ECR will store container images
- Helm will deploy and update Kubernetes application resources
- Kubernetes rolling updates will minimise application downtime
- Failed application releases must support rollback to a previous version
- Infrastructure and application changes will be reviewed before deployment 
- CI/CD automation will be added later to automate build, test and deployment stages

## Architecture Decisions

- Use Terraform instead of manually creating AWS infrastructure
- Use EKS managed node groups because AWS manages more of the worker-node lifecycle while still allowing control over EC2 capacity
- Keep worker nodes in private subnets because they should not be directly reachable from the internet, while allowing controlled outbound access through a NAT Gateway when required
- Use EKS Pod Identity for workload AWS permissions because it allows Pods to assume IAM Roles without storing long-lived AWS access keys inside the container
- Use an Application Load Balancer for public application traffic because it provides managed Layer 7 HTTP/HTTPS routing and distributes requests across healthy application targets
- Use Helm to manage Kubernetes application releases because Helm is like a package manager that bundles YAML files for an app so you can install, upgrade, configure and roll back the app more easily
- Use CloudWatch as the first monitoring platform because CloudWatch provides metrics, logs and alerts in a central location for monitoring and troubleshooting. 
- Use Horizontal Pod Autoscaler for application scaling because it automatically increases and decreases the number of Pods based on defined resource metrics such as CPU and memory usage
- Use Cluster Autoscaler for worker-node scaling because it automatically adds nodes when Pods cannot be scheduled due to insufficient capacity and removes nodes when their workloads can be safely moved elsewhere
- Use multiple Availability Zones for resilience so the application can continue running if one Availability Zone becomes unavailable.