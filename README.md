# AWS EKS Production-Ready Cluster Using VPC Module with Terraform
  This repository contains a Terraform configuration for setting up a production-ready Amazon EKS (Elastic Kubernetes Service) cluster on AWS. 
  The configuration follows best practices for infrastructure as code, modularity, and scalability, making it easy to deploy, manage, and scale Kubernetes workloads in a secure environment.

# Configuration Overview
  This Terraform configuration includes the following components:

  1. VPC Setup (vpc.tf)
     - Creates a custom Virtual Private Cloud (VPC) with public and private subnets across multiple availability zones for high availability.
     - Configures an Internet Gateway and route tables to manage network traffic.
  2. IAM Roles (iam.tf):
     - Sets up IAM roles and policies required for the EKS control plane and worker nodes, ensuring proper permissions for Kubernetes operations.
  3. EKS Cluster (eks.tf):
     - Deploys an Amazon EKS cluster with a managed node group, enabling scalable container orchestration.
     - Uses private subnets for worker nodes to enhance security by limiting direct internet exposure.
  4. Outputs (outputs.tf):
     - Provides essential outputs, such as the EKS cluster endpoint and IAM role ARN, for easy access and further configuration.
  5. Variables (variables.tf):
     - Allows customization of configuration parameters, including VPC CIDR blocks, instance types, scaling options, and region.
  6. Provider Configuration (provider.tf):
     - Specifies the AWS provider settings, such as region, for deploying the infrastructure.
  7. Security Groups (sg.tf):
     - This file defines the security group for the EKS cluster, allowing inbound and outbound traffic for communication between the nodes and the 
       control plane, as well as access from outside the cluster

       - Cluster Security Group (aws_security_group.eks_cluster_sg):
         - Allows inbound HTTPS (port 443) traffic for communication with the EKS control plane.
         - Allows all traffic within the security group itself (nodes and control plane).
         - Permits all outbound traffic, which is necessary for the cluster's operations.

       - Node Security Group (aws_security_group.eks_node_sg):
         - Allows all traffic within the VPC CIDR, enabling communication among nodes.
         - Allows inbound SSH traffic (port 22) for management purposes.
         - Allows all traffic from the EKS cluster security group, facilitating communication between the control plane and worker nodes.
         - Allows all outbound traffic, ensuring the nodes can access required resources.
  8. Data Sources (sata_sources.tf):
     - This is used fetch the availability zones in the specified region. This will allow the azs parameter to be used properly in the VPC module
       configuration.
       - The data "aws_availability_zones" block fetches the available availability zones in the specified region (eu-west-2 in this case, as set in
         provider.tf).
       - The azs parameter in the VPC module now references data.aws_availability_zones.available.names, which provides a list of available AZ names.
    
# Getting Started
  - Clone the Repository by executing this command - git clone https://github.com/techkedgeconnect/tec-eks-terraform-configuration.git
    - cd tec-eks-terraform-configuration
  - Initialize terraform by executing this command - terraform init
  - Apply the configuration by executing this command - terraform apply

# Prerequisites
  - Terraform v1.0+
  - AWS CLI configured with the necessary credentials
  - An existing AWS account

# Features
  - High availability with multi-AZ deployment
  - Secure, private subnets for worker nodes
  - Infrastructure as code for reproducibility and version control

# Contribution
  Contributions are welcome! Please feel free to submit issues or pull requests for improvements.

  
