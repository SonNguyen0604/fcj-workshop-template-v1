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

<img width="1466" height="653" alt="{91937960-746A-4A4D-8B29-0753BB689873}" src="https://github.com/user-attachments/assets/5174d97c-0bd5-49fb-bbbf-4237a61a6241" />
`![VPC Architecture](/images/vpc-setup.png)`

### 2. Database Provisioning (RDS PostgreSQL Multi-AZ)

Instead of hosting the database directly on an EC2 instance (which introduces a Single Point of Failure), I utilized **Amazon RDS (PostgreSQL)**.

The critical factor for this implementation is enabling **Multi-AZ Deployment**. When activated, AWS automatically provisions and maintains a synchronous standby replica in a different AZ. In the event of an infrastructure failure, Amazon RDS performs an automatic failover to the standby, preventing data loss.

<img width="1906" height="858" alt="{AFEFA673-FB31-43EA-9B65-4ADD6D86FBC5}" src="https://github.com/user-attachments/assets/cacd926c-1b5f-4c9f-851d-97b438feeda1" />
`![RDS Multi-AZ](/images/rds-multiaz.png)`
