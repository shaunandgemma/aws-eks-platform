# Network Addressing Plan

## VPC CIDR

- 10.0.0.0/16

## Availability Zones

- eu-west-2a 
- eu-west-2b

## Public Subnets

- 10.0.1.0/24 - eu-west-2a
- 10.0.2.0/24 - eu-west-2b

## Private Subnets

- 10.0.10.0/24 - eu-west-2a
- 10.0.20.0/24 - eu-west-2b

## Routing Design

- Public subnets will use a route table to access the Internet Gateway via 0.0.0.0/0
- Private subnets will use a separate route table associated with the private subnet
- Private subnet default routes will point to NAT Gateway(s), not directly to the Internet Gateway
- Public and private subnets must remain logically separate 
- Route table associations must match the intended subnet type

## NAT Gateway Design

- Create one NAT Gateway in each public subnet
- NAT Gateway A serves the private subnet in eu-west-2a
- NAT Gateway B serves the private subnet in eu-west-2b
- Each private subnet routes 0.0.0.0/0 to the NAT Gateway in the same Availability Zone
- This prevents a NAT Gateway failure in one AZ from removing outbound connectivity from both AZs
- Because NAT Gateways cost money, the project teardown must remove them when testing is complete

## Security Boundaries

- The ALB is the only internet-facing application entry point
- EKS worker nodes must not have public IP addresses
- Public subnets must contain only resources that require internet-facing connectivity
- Private subnets must contain the EKS worker nodes and application workloads
- Security groups must allow only the required traffic between components
- Application workloads must accept application traffic only from the load-balancing path
- Outbound internet access from private subnets must pass through the NAT Gateway(s)
- No application credentials or secrets may be exposed through the network design