---
title: "Week 7 Worklog"
date: 2026-08-03
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Period

**03/08/2026 - 09/08/2026**

### Work completed / planned

* Terminated one EC2 instance managed by the Auto Scaling Group.
* Observed the Target Group mark the failed target unhealthy after health checks and the ASG launch a replacement to restore Desired Capacity.
* Collected evidence from AWS Console, the web application, and CloudWatch for the report/workshop.
* Reviewed the internship report to keep statements about RDS, CloudWatch, S3, and failover technically accurate.

### Results

* Demonstrated application-tier self-healing after an EC2 termination.
* Collected visual evidence for ALB/ASG/CloudWatch and the demo application.
* Downtime/error rate and RDS failover were not measured; these limitations are documented.
