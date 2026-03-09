# EKS + Terraform Demo Project

This repository contains Terraform code to deploy an **Amazon EKS (Elastic Kubernetes Service) cluster** with a simple **Nginx deployment** on AWS. The project demonstrates best practices for Terraform module usage, Kubernetes resource management, and EKS user access configuration.


!!! N.B. Provide the eks_admin_user_arn variable if prompted (your IAM user ARN) !!!

---

## Project Structure

aws-eks-terraform
│
├── terraform/
│    ├── main.tf       # Main Terraform configuration (EKS, VPC, Node Groups)
│    ├── variables.tf  # Terraform input variables
│    ├── outputs.tf    # Terraform outputs
│    └── providers.tf  # AWS provider
└── kubernetes/
     ├── outputs.tf    # Kubernetes outputs
     └── k8s.tf        # Kubernetes provider, cluster auth, deployment and service

## Features

- **VPC & Networking**
  - Dedicated VPC for EKS
  - Public & private subnets across multiple AZs
  - NAT Gateway for internet access from private subnets
  - Subnet tags for Kubernetes service load balancers

- **EKS Cluster**
  - EKS cluster version `1.29`
  - Managed node groups
  - Public cluster endpoint enabled

- **Kubernetes Resources**
  - Nginx deployment with 2 replicas
  - LoadBalancer service exposing Nginx publicly

- **IAM User Access**
  - ***Provide the eks_admin_user_arn variable if prompted (your IAM user ARN)***
  - Updates `aws-auth` ConfigMap automatically

- **Terraform Modules**
  - [`terraform-aws-modules/vpc/aws`](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) for networking
  - [`terraform-aws-modules/eks/aws`](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) for EKS cluster and node groups

---

## Prerequisites

- Terraform >= 1.7
- AWS CLI configured with appropriate IAM credentials
- `kubectl` installed
- AWS account permissions for EKS, VPC, and IAM