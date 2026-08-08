---
title: "Workshop - High Availability on AWS with Terraform"
date: 2026-08-08
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Building a 3-Tier High Availability Architecture on AWS with Terraform

This is my **individual technical project**, rewritten as an end-to-end workshop so readers can understand the architecture, inspect the source, deploy the lab, validate the result and clean up resources.

## Workshop objectives

After this workshop, readers should be able to:

* understand a 3-tier architecture spanning two Availability Zones;
* deploy VPC, Security Groups, RDS Multi-AZ, S3, ALB, Launch Template, Auto Scaling Group and CloudWatch with Terraform;
* access the Flask demo through the ALB;
* terminate one EC2 instance and observe the ASG restore Desired Capacity;
* distinguish self-healing from dynamic scaling;
* understand cost, security and operational trade-offs in the lab design;
* clean up resources to avoid unnecessary cost.

## Actual scope

The workshop only describes implemented items or explicitly documented limitations. The Flask demo **only displays the RDS endpoint** and does not connect/query the database; the CloudWatch Alarm monitors CPU only; RDS failover, quantitative downtime/error-rate measurement and centralized application logging were not implemented/tested.

## Contents

1. [Architecture overview and service selection](5.1-workshop-overview/)
2. [Prerequisites and environment setup](5.2-prerequisites/)
3. [Network, Security, RDS and S3](5.3-network-database/)
4. [EC2 Launch Template and Auto Scaling Group](5.4-compute-scaling/)
5. [Application Load Balancer and CloudWatch](5.5-load-balancing/)
6. [Testing and validation](5.6-failover-test/)
7. [Optimization, security and limitations](5.7-optimization-limitations/)
8. [Clean-up](5.8-cleanup/)

## Attached Terraform source

* [main.tf](/fcj-workshop-template-v1/files/terraform/main.tf)
* [terraform.tfvars.example](/fcj-workshop-template-v1/files/terraform/terraform.tfvars.example)
* [Execution README](/fcj-workshop-template-v1/files/terraform/README.md)

The source is also available in the repository:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>
