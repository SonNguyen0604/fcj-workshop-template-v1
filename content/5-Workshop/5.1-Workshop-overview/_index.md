---
title: "5.1 Architecture overview"
date: 2026-08-08
weight: 1
---

## Overall architecture

![3-tier High Availability architecture](/images/5-Workshop/5.1-workshop-overview/ha-architecture.png)

Main traffic flow:

**User -> Internet Gateway -> Application Load Balancer -> EC2 instances in the Auto Scaling Group**

The data tier uses **PostgreSQL RDS Multi-AZ**. S3 provides object storage independent from the EC2 lifecycle, while CloudWatch provides basic monitoring.

## Services and selection rationale

| Service | Role | Why it was selected |
|---|---|---|
| VPC + Subnets | Network isolation | Separate public/app/database tiers across two AZs |
| ALB | Entry point + health check | Routes requests only to healthy targets |
| EC2 | Runs the Flask demo | Makes instance/hostname behavior easy to observe |
| Auto Scaling Group | Maintains capacity | Launches replacement instances when actual capacity drops |
| RDS PostgreSQL Multi-AZ | Database tier | Managed database with a synchronous standby in another AZ |
| S3 + Versioning | Object storage | Separates object storage from the EC2 lifecycle |
| CloudWatch | Monitoring | Monitors CPU and Alarm state |
| Terraform | Infrastructure as Code | Repeatable provisioning, review and clean-up |

## Network separation and security boundary

* **Public subnets:** ALB and NAT Gateway.
* **Private subnets:** EC2 application instances; no direct public inbound traffic.
* **Database subnets:** RDS; PostgreSQL inbound is allowed only from `app-sg`.
* **Security Group chain:** Internet -> `alb-sg` -> `app-sg` -> `db-sg`.

## Where is High Availability implemented?

* The application tier maintains at least two EC2 instances across two private subnets.
* ALB health checks prevent traffic from being routed to unhealthy targets.
* ASG maintains Desired Capacity and replaces lost instances.
* RDS is configured with `multi_az = true` so AWS manages a synchronous standby in another AZ.

## Lab trade-off

`single_nat_gateway = true` reduces cost but leaves the NAT Gateway as a shared dependency. This is a **lab trade-off**, not a fully redundant production HA design.
