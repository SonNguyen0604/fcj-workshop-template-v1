---
title: "Blog 3 - RDS Multi-AZ and CloudWatch: more resilient data and better observability"
date: 2026-08-08
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---

# RDS Multi-AZ + CloudWatch: two important pieces of an HA architecture

High Availability is not only about having multiple EC2 instances. If the data tier still depends on one database or the system has no monitoring, operations become difficult when failures occur.

In my project, **Amazon RDS PostgreSQL Multi-AZ** improves database resilience while **Amazon CloudWatch** provides infrastructure monitoring.

## What problem does RDS Multi-AZ solve?

With `multi_az = true`, RDS maintains a synchronous standby in another Availability Zone. AWS manages the failover mechanism and database endpoint.

Important notes:

* Multi-AZ focuses on **high availability**, not read scaling.
* Applications should use the RDS endpoint instead of hard-coding a database IP address.
* Failover may cause temporary interruption; it should not be described as guaranteed zero downtime.

In the current demo, I deployed RDS Multi-AZ but **did not run an RDS failover experiment**, and Flask does not query the database yet. I document this limitation instead of claiming untested results.

## CloudWatch in the project

I configured a CloudWatch Metric Alarm for EC2 `CPUUtilization`. The current alarm is for monitoring only; it is **not connected to a scaling policy**.

Application logs are stored in `app.log` on each EC2 instance. This is a limitation because local logs follow the instance lifecycle. A future improvement is CloudWatch Agent or another centralized logging solution.

## Operations lessons

* HA should be observable: without metrics and logs, recovery behavior is difficult to understand.
* Monitoring and Auto Scaling are related but not the same thing.
* Managed services such as RDS Multi-AZ reduce operational work, but failover behavior still needs to be tested and understood.
* Good technical documentation should clearly separate what was **tested** from what was only **configured**.

---

**Article created:** 08/08/2026

---

## Sharing information

* **Content created:** 08/08/2026
* **Published:** 08/08/2026
* **Published in:** AWS Study Group VN
* **Status:** Published and approved by the group administrators.

## Evidence

{{< siteimg src="images/3-BlogsPosted/blog3-aws-study-group.png" alt="RDS Multi-AZ and CloudWatch post shared in AWS Study Group VN" >}}
