---
title: "Worklog Week 7"
date: 2026-08-03
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Time

**03/08/2026 - 09/08/2026**

### Work completed

* Terminated one EC2 instance managed by the Auto Scaling Group to test application-tier recovery.
* Observed the Target Group remove the failed target after health checks and the ASG launch a replacement to restore Desired Capacity.
* Collected evidence from Terraform/AWS Console, the web application, EC2 and CloudWatch.
* Finalized three technical blog articles and added information/evidence for the three events attended.
* Reviewed Vietnamese/English content, Terraform source, links, images and technical limitations so that the website matched the actual implementation.
* Completed the technical project/workshop for **submission on 08/08/2026**.

### Results

* Demonstrated application-tier self-healing when one EC2 instance was terminated.
* Added visual evidence for Terraform validation, ALB/Flask access, EC2 replacement and the CloudWatch Alarm.
* Completed the bilingual Worklog, Proposal, Blogs, Events, Workshop, Self-evaluation and Feedback sections.
* Clearly documented unimplemented items such as RDS failover, downtime/error-rate measurement, centralized logging and dynamic scaling.
* The technical project and workshop reached a submission-ready state on **08/08/2026**.
