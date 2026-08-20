# Project Requirements



## Functional Requirements



* The application must run inside Kubernetes on Amazon EKS
* Users must be able to reach the application through a public endpoint
* The application must run from a Docker image stored in Amazon ECR
* Kubernetes must keep the required number of application Pods running
* The application must support configuration without changing the container image
* The platform must support controlled application updates



## Infrastructure Requirements



* The platform must be provisioned using Terraform
* Amazon EKS must provide the Kubernetes control plane
* EKS managed node groups must provide worker compute 
* Amazon ECR must store the application container image
* The platform must use a dedicated VPC with public and private subnets across at least two Availability Zones
* Application workloads must run on private worker nodes
* An Application Load Balancer (ALB) must provide external access to the application 
* Kubernetes application resources must be deployed using Helm where appropriate



## Security Requirements



* IAM permissions must follow least privilege
* EKS workloads must use IAM roles rather than long-lived AWS access keys
* Worker nodes must run in private subnets
* Secrets must not be stored directly in source code or container images
* Security groups must only allow required traffic
* Kubernetes access must be restricted to authorised users and roles
* AWS and Kubernetes activity must be logged for auditing and troubleshooting



## Availability and Scaling Requirements



* The EKS worker nodes must span at least two Availability Zones
* The application must run with multiple Pods to avoid a single point of failure
* Kubernetes must automatically replace failed application Pods
* Application Pods must scale automatically based on demand
* Worker-node capacity must scale when the cluster requires more compute
* The load balancer must distribute traffic across healthy application instances



## Monitoring Requirements



* EKS cluster and application metrics must be collected in CloudWatch
* Application logs must be centrally available for troubleshooting
* CPU and memory usage must be monitored
* Pod and node health must be monitored
* Alerts must be created for important failures or unhealthy conditions
* Load balancer health and request behaviour must be monitored
* Monitored data must support troubleshooting and incident investigation



## Deployment Requirements



* Application containers must be built from version-controlled source code
* Container images must be stored in Amazon ECR
* Kubernetes application releases must be managed with Helm
* Infrastructure changes must be applied through Terraform
* Deployment changes must be reviewable through Git
* Application updates must avoid unnecessary downtime
* Previous application versions must be recoverable if a deployment fails



## Cost Requirements



* Resources must use cost-effective sizes suitable for a training environment
* Expensive resources must only be created when required
* Unused resources must be removed after testing
* AWS costs must be reviewed during the project
* The project must include a documented teardown process 
* Cost decisions must not compromise required security or availability



## Success Criteria



* The application is successfully deployed to Amazon EKS
* Users can access the application through the Application Load Balancer
* Application images are built and stored in Amazon ECR
* Terraform can create and destroy the required AWS infrastructure
* Helm can deploy and update the Kubernetes application
* Pods recover automatically after failure
* Application Pods scale automatically when demand increases
* Worker-node capacity can scale when required
* IAM access must follow least privilege
* Logs, metrics and alerts are visible in CloudWatch
* A failed deployment can be rolled back successfully
* The full environment can be safely destroyed without leaving unnecessary resources


