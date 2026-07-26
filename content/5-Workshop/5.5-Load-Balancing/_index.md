---
title: "5.5 Load Balancing (ALB)"
date: 2026-07-27T10:20:00+07:00
weight: 5
---

### Traffic Distribution with Application Load Balancer

Since the application resides in Private Subnets and the number of instances can fluctuate dynamically (due to Auto Scaling), users cannot access the EC2 instances directly. Therefore, an **Application Load Balancer (ALB)** is provisioned in the Public Subnets to act as the Single Entry Point.

The ALB performs the following critical tasks:
1.  **Traffic Routing:** Evenly distributes incoming user traffic across all healthy EC2 instances spanning multiple AZs.
2.  **Health Checks:** Continuously pings the application's `/health/ready` endpoint. If an instance responds with an error (e.g., HTTP 500) or times out, the ALB stops routing traffic to that specific instance, ensuring a seamless user experience.

*(Insert your ALB Target Group screenshot showing Targets in "Healthy" status here)*
`![ALB Target Group](/images/alb-target-group.png)`
