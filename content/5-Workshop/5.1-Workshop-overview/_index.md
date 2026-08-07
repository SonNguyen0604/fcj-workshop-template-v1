---
title: "5.1 Architecture overview"
date: 2026-08-08
weight: 1
---

## Problem

The architecture avoids making the application tier depend on a single EC2 instance. The lab uses two Availability Zones in `ap-southeast-1`.

![3-tier High Availability architecture](/images/5-Workshop/5.1-Workshop-overview/ha-architecture.png)

## Request flow

**User -> Internet Gateway -> Application Load Balancer -> EC2 instances in Auto Scaling Group**

The data tier uses **RDS PostgreSQL Multi-AZ**. S3 and CloudWatch provide object storage/monitoring within the current project scope.

## Services and rationale

| Service | Role | Why it is used |
|---|---|---|
| VPC + Subnets | Network isolation | Separate public/app/database tiers across two AZs |
| ALB | Entry point + health check | Route requests only to healthy targets |
| EC2 | Run the Flask demo | Easy to observe hostname/instance behavior in the lab |
| Auto Scaling Group | Maintain capacity | Launch a replacement when actual capacity drops |
| RDS PostgreSQL Multi-AZ | Database tier | Managed DB with synchronous standby in another AZ |
| S3 + Versioning | Object storage | Separate object storage from the EC2 lifecycle |
| CloudWatch | Monitoring | Monitor CPU and Alarm state |
| Terraform | Infrastructure as Code | Reproducible deployment, review, and clean-up |

## Lab trade-off

The project uses `single_nat_gateway = true` to reduce cost. This leaves the NAT Gateway as a shared dependency and is not a fully redundant production NAT design. A production environment should evaluate a per-AZ NAT strategy or another design suitable for the workload.
