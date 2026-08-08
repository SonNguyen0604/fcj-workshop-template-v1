---
title: "Technical Blog Articles"
date: 2026-06-24
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

During the internship, I prepared three technical articles directly related to the High Availability project. They are used to organize what I learned and to document the configurations and lessons from my AWS lab work.

> This section records the **content creation date** of each article. The articles are kept on my personal workshop site and are not described as publicly published AWS Study Group posts.

## [Blog 1 - Proactive cost control with AWS Budgets](3.1-Blog1/)

* **Created:** 24/06/2026.
* **Topic:** Basic cost control/FinOps for a lab account.
* **Project connection:** Cost control before running resources such as NAT Gateway, EC2, ALB, and RDS Multi-AZ.

## [Blog 2 - ALB + Auto Scaling Group: building a self-healing application tier](3.2-Blog2/)

* **Created:** 08/08/2026.
* **Topic:** Health checks, Desired Capacity, self-healing, and the difference between capacity maintenance and dynamic scaling.
* **Project connection:** The actual EC2 termination -> unhealthy target -> ASG replacement flow.

## [Blog 3 - RDS Multi-AZ + CloudWatch: resilience and observability](3.3-Blog3/)

* **Created:** 08/08/2026.
* **Topic:** Multi-AZ database, monitoring, alarms, and observability limitations in the demo.
* **Project connection:** Separating configured components from untested items such as RDS failover and centralized logging.
