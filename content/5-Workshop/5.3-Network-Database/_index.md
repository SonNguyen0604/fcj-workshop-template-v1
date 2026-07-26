---
title: "5.3 Network & Database Setup"
date: 2026-07-27T10:00:00+07:00
weight: 3
---

### 1. Network Infrastructure Provisioning (VPC)

To achieve High Availability, the network infrastructure is deployed across 2 different Availability Zones (AZs). I utilized **Terraform** to automate the creation of the network topology, which includes:
*   **1 Virtual Private Cloud (VPC)**.
*   **2 Public Subnets** for the Application Load Balancer (ALB) and NAT Gateway.
*   **2 Private Subnets** for application EC2 instances.
*   **2 Database Subnets** strictly isolated from the Internet for the database tier.

*(Insert your VPC screenshot from AWS Console here)*
`![VPC Architecture](/images/vpc-setup.png)`

### 2. Database Provisioning (RDS PostgreSQL Multi-AZ)

Instead of hosting the database directly on an EC2 instance (which introduces a Single Point of Failure), I utilized **Amazon RDS (PostgreSQL)**.

The critical factor for this implementation is enabling **Multi-AZ Deployment**. When activated, AWS automatically provisions and maintains a synchronous standby replica in a different AZ. In the event of an infrastructure failure, Amazon RDS performs an automatic failover to the standby, preventing data loss.

*(Insert your RDS screenshot showing Multi-AZ = Yes here)*
`![RDS Multi-AZ](/images/rds-multiaz.png)`
