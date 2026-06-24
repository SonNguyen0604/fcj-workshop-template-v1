---
title: "Project Proposal"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

### 1. Project Overview
This project focuses on researching and practically implementing an infrastructure capable of fault tolerance and ensuring High Availability (HA) for applications deployed on the AWS cloud platform. This architecture simulates a production-grade environment where the application must run continuously 24/7, even during a complete data center (Availability Zone) outage.

### 2. Problem Statement
* **Downtime Risks:** Systems operating on a single server (Single Point of Failure) are highly vulnerable to hardware failure or localized physical disasters at the data center.
* **Overload Challenges:** When traffic spikes unexpectedly, traditional infrastructure fails to scale automatically, resulting in network congestion and server crashes.
* **Data Loss:** Databases that lack real-time synchronization across independent zones run a high risk of permanent data loss in the event of a critical failure.

### 3. Project Objectives
* Successfully deploy a containerized Python demo application using Docker.
* Design an enterprise-grade AWS VPC partitioned into Public and Private Subnets across Multi-AZs.
* Configure automated traffic routing using an Application Load Balancer (ALB) and dynamic computing allocation via an Auto Scaling Group (ASG).
* Deploy an Amazon RDS database with automated backup policies and Multi-AZ replication enabled.
* Establish a centralized logging, monitoring, and alerting system via Amazon CloudWatch.

### 4. Proposed Solution Architecture
The system integrates core AWS services to realize the HA model:
* **Networking:** An AWS VPC spanning 2 independent Availability Zones (AZ-A and AZ-B). Each AZ contains a Public Subnet (hosting the ALB) and a Private Subnet (hosting the application EC2 instances).
* **Compute:** Amazon EC2 Instances running the Python application, centrally orchestrated by an Auto Scaling Group.
* **Load Balancing:** An Application Load Balancer (ALB) receives internet traffic and distributes it evenly to EC2 instances across both AZs.
* **Database:** Amazon RDS (MySQL/PostgreSQL) with Multi-AZ deployment enabled for real-time standby replication.
* **Storage:** Amazon S3 used for durable object storage of static assets and application attachments.
* **Management & Monitoring:** AWS IAM roles for implementing the Principle of Least Privilege, and Amazon CloudWatch for metric monitoring.

### 5. Compressed 5-Week Timeline
* **Week 1:** Finalize high-level architecture, initialize the reporting framework, and develop the Python application.
* **Week 2:** Provision Multi-AZ VPC network, initialize RDS, S3, and containerize the application with Docker.
* **Week 3:** Configure Application Load Balancer (ALB) and Auto Scaling Group (ASG) to achieve High Availability infrastructure.
* **Week 4:** Set up Amazon CloudWatch monitoring, conduct Failover testing (simulating an AZ outage), and publish 3 technical blog posts.
* **Week 5:** Optimize cloud spending, tighten IAM security policies, execute resource Clean-up to avoid unnecessary billing, and conduct final review.

### 6. Estimated Budget
* Operating strictly within the **AWS Free Tier** limits paired with the **$200 Credit** provided by the First Cloud Journey program.
* Configure AWS Budgets to alert immediately if expenditures exceed a $5 threshold.

### 7. Risks and Mitigations
* **Risk:** Misconfigured Security Groups or IAM Roles could expose critical resources or private data to the public internet.
* **Mitigation:** Strictly adhere to the Principle of Least Privilege, isolate EC2 and RDS instances inside Private Subnets, and completely avoid hard-coding any Access Keys into the application codebase.
