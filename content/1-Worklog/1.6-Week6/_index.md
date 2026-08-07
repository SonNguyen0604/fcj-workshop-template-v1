---
title: "Week 6 Worklog"
date: 2026-06-22
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---

### Period

**27/07/2026 - 02/08/2026**

### Work completed / planned

* Configured a CloudWatch Metric Alarm for CPUUtilization.
* Reviewed the difference between monitoring alarms and dynamic scaling policies; the current alarm is not described as a CPU scaling trigger.
* Verified that application logs are stored in app.log on EC2 and documented the lack of centralized logging/CloudWatch Agent.
* Reviewed Terraform resources, S3 Versioning, ELB health checks, naming, and lab limitations.

### Results

* CloudWatch Alarm is available for CPU monitoring.
* Technical documentation now matches what is actually deployed.
* Project limitations are explicitly documented instead of overstating results.
