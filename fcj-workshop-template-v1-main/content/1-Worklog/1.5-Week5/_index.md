---
title: "Week 5 Worklog"
date: 2026-07-20
weight: 5
chapter: false
pre: " <b> 1.5. </b> "
---

### Period

**20/07/2026 - 26/07/2026**

### Work completed / planned

* Created a Launch Template based on Amazon Linux 2023 and user_data for the Flask demo.
* Created an Application Load Balancer, Target Group, and HTTP listener on port 80.
* Configured the health check on path '/' for the lab environment.
* Created an Auto Scaling Group across two private subnets with min = 2, desired = 2, max = 3, and health_check_type = ELB.

### Results

* At least two application instances are maintained by the ASG.
* The ALB can route requests to healthy targets.
* The ASG can restore Desired Capacity when an instance is lost.
