---
title: "Week 4 Worklog"
date: 2026-06-22
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---

### Period

**13/07/2026 - 19/07/2026**

### Work completed / planned

* Deployed VPC 10.0.0.0/16 with six subnets across ap-southeast-1a and ap-southeast-1b.
* Used one NAT Gateway for the lab to reduce cost and documented this as an HA trade-off.
* Deployed PostgreSQL RDS with multi_az = true and a dedicated database subnet group.
* Created an S3 bucket with Versioning and restricted the database Security Group to app-sg.

### Results

* Completed the Network and Data layers of the 3-tier architecture.
* RDS is placed in database subnets and is not directly public.
* S3 is independent of the EC2 lifecycle, although Flask upload/download integration is not implemented.
