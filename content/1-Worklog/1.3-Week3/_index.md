---
title: "Week 3 Worklog"
date: 2026-06-22
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---

### Period

**06/07/2026 - 12/07/2026**

### Work completed / planned

* Built a Python/Flask web demo to act as the workload for HA infrastructure testing.
* Created user_data so EC2 installs Python/Flask, generates app.py, and starts the service automatically.
* Defined db_password as a sensitive Terraform variable instead of hard-coding it in the RDS resource.
* Started Terraform configuration for the VPC, subnets, and ALB/App/DB Security Groups.

### Results

* The Flask demo can return the EC2 hostname and display the RDS endpoint injected by Terraform.
* The Terraform structure clearly separates traffic between tiers.
* No real access key or database password is stored directly in the source code.
