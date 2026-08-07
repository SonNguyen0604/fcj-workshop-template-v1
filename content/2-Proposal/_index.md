---
title: "Project Proposal"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

## 1. Project overview

**Project:** High Availability on AWS using Terraform.

The project builds a 3-tier AWS lab environment to demonstrate how to reduce dependency on a single application server. A Python/Flask application is used as the demo workload; the main focus is cloud infrastructure design, deployment, operations, and failure testing.

## 2. Problem statement

* A single EC2 instance creates a Single Point of Failure at the application tier.
* Without a Load Balancer, users depend on individual server addresses.
* The database tier needs better resilience than a single DB instance.
* Manual provisioning is error-prone and difficult to reproduce or clean up.
* The lab must control costs, especially NAT Gateway and RDS Multi-AZ runtime.

## 3. Objectives and success criteria

* Build a VPC across **two Availability Zones** with public, private, and database subnets.
* Place the **Application Load Balancer** in public subnets and EC2 in private subnets.
* Maintain **two EC2 instances** in an Auto Scaling Group with `health_check_type = "ELB"`.
* Deploy **RDS PostgreSQL Multi-AZ** and S3 Versioning.
* Manage infrastructure using **Terraform**.
* Configure a **CloudWatch CPU Alarm** for monitoring.
* Terminate one EC2 instance and observe ASG replacement behavior.
* The test is considered successful when the ALB still has a healthy target serving traffic and the ASG restores Desired Capacity.

## 4. Solution architecture

Main services:

* **Amazon VPC:** 10.0.0.0/16 with six subnets across two AZs.
* **Internet Gateway + NAT Gateway:** Internet-facing ALB; private EC2 outbound through NAT.
* **Application Load Balancer:** user entry point and target health checking.
* **Amazon EC2 + Auto Scaling Group:** application tier, min = 2, desired = 2, max = 3.
* **Amazon RDS PostgreSQL Multi-AZ:** managed database with synchronous standby.
* **Amazon S3:** Versioning enabled; Flask upload/download integration is outside the current implementation.
* **Amazon CloudWatch:** CPU monitoring; application logs are still local in `app.log` on EC2.

![HA architecture](/images/5-Workshop/5.1-Workshop-overview/ha-architecture.png)

## 5. Eight-week timeline

| Week | Main work |
|---|---|
| 1 | Kick-off, project selection, template fork, AWS Budgets |
| 2 | Networking, HA theory, architecture diagram, Terraform foundation |
| 3 | Flask demo, user_data, Security Groups, sensitive variable |
| 4 | Two-AZ VPC, RDS Multi-AZ, S3 Versioning |
| 5 | ALB, Target Group, Launch Template, ASG |
| 6 | CloudWatch Alarm, security and limitation review |
| 7 | EC2 termination test, self-healing observation, evidence collection |
| 8 | Workshop, blogs, events, report finalization, and clean-up |

## 6. Budget and cost control

AWS Budgets is configured with a small warning threshold to detect unexpected spending early. It is a **warning threshold**, not a guarantee that the total project cost always remains below that number. NAT Gateway and RDS Multi-AZ can generate charges, so resources are kept only during the required lab windows and cleaned up afterwards.

## 7. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Credential/password exposure | Do not hard-code access keys; use CloudShell/CLI profiles and a Terraform sensitive variable |
| Direct EC2/RDS exposure | Keep EC2/RDS private; SG chain ALB -> App -> DB |
| Single NAT Gateway as a SPOF | Accepted lab cost trade-off; production should use a per-AZ NAT strategy or another suitable design |
| Local logs lost with EC2 termination | Documented limitation; future improvement is CloudWatch Agent/centralized logging |
| No dynamic scaling policy | Current CloudWatch Alarm is monitoring only; Target Tracking is a future improvement |
| Unexpected cost | AWS Budgets + `terraform destroy` after testing |

## 8. Out of scope in the current version

* No full Workforce business application.
* Flask does not connect to or query RDS yet.
* No RDS failover experiment and no measured downtime/error rate.
* No application-side S3 integration.
* No centralized application logging or dynamic scaling policy.
