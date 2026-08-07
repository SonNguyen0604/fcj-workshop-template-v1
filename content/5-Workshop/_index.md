---
title: "Workshop - High Availability on AWS using Terraform"
date: 2026-08-08
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Building a 3-tier High Availability architecture on AWS using Terraform

This workshop documents my **individual technical project** as a reproducible, step-by-step lab for a basic High Availability environment on AWS.

### Goals

After completing the workshop, the reader should be able to:

* understand a 3-tier architecture across two Availability Zones;
* deploy VPC, Security Groups, RDS Multi-AZ, S3, ALB, Launch Template, ASG, and CloudWatch using Terraform;
* access the Flask demo through the ALB;
* terminate one EC2 instance and observe ASG restoring Desired Capacity;
* clean up resources to avoid unnecessary cost.

### Actual scope

The workshop only claims what was deployed or clearly marks limitations. Flask currently displays the RDS endpoint but does not query the database; the CloudWatch Alarm monitors CPU only; RDS failover/downtime/error rate were not tested; centralized application logging is not implemented.

### Contents

1. [Architecture overview and service selection](5.1-Workshop-overview/)
2. [Prerequisites and environment setup](5.2-Prerequiste/)
3. [Network, Security, RDS, and S3](5.3-Network-Database/)
4. [EC2 Launch Template and Auto Scaling Group](5.4-Compute-Scaling/)
5. [Application Load Balancer and CloudWatch](5.5-Load-Balancing/)
6. [Testing and validation](5.6-Failover-Test/)
7. [Clean-up](5.7-Cleanup/)

### Terraform source

The workshop source is stored under `static/files/terraform/` in the repository. After pushing this update, it can be viewed at:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>
