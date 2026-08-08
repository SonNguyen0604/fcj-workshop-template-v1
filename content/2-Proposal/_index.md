---
title: "Project Proposal"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

## 1. Project overview

**Project name:** High Availability on AWS using Terraform.

The project builds a 3-tier lab environment on AWS to demonstrate how to reduce dependency on a single application server. A small Python/Flask application is used as the workload; the main focus is **architecture design, Infrastructure as Code deployment, self-healing validation, and an end-to-end technical workshop**.

## 2. Context and problem statement

* A single EC2 instance creates a Single Point of Failure at the application tier.
* Direct access to individual EC2 instances makes replacement harder because endpoints change.
* The database tier needs stronger redundancy than a single standalone instance.
* Manual provisioning is difficult to reproduce consistently and clean up safely.
* A lab environment needs cost controls so NAT Gateway/RDS resources do not run longer than required.

## 3. Target users / use-case

This project targets **learning, architecture demonstration and hands-on workshop use** for students or beginners learning AWS. Readers can use the Terraform source and the workshop to understand how multiple AWS services work together to provide better resilience than a single-server design.

## 4. Objectives, outputs and success criteria

### Expected outputs

* A public ALB endpoint serving the Flask demo over HTTP.
* Two EC2 instances managed by an Auto Scaling Group and registered in a Target Group.
* PostgreSQL RDS running in Multi-AZ mode.
* An S3 bucket with Versioning enabled.
* A CloudWatch Alarm monitoring CPU.
* Terraform source for deployment and clean-up.
* A bilingual workshop containing architecture, step-by-step deployment, validation, limitations and clean-up.

### Success criteria

* The VPC spans **2 Availability Zones** with public, private and database subnets.
* ALB is placed in public subnets, EC2 in private subnets, and RDS in database subnets.
* ASG maintains `min_size = 2`, `desired_capacity = 2`, `max_size = 3` with `health_check_type = "ELB"`.
* `terraform validate` succeeds and `terraform apply` manages the intended infrastructure/state.
* The ALB endpoint returns HTTP 200 from the Flask demo.
* After one EC2 instance is terminated, the ASG launches a replacement and restores Desired Capacity.
* A CloudWatch Alarm exists and displays the CPU metric.

## 5. Solution architecture

Main services:

* **Amazon VPC:** 10.0.0.0/16 network with six subnets across two AZs.
* **Internet Gateway + NAT Gateway:** public inbound to the ALB; outbound Internet access for private EC2 instances.
* **Application Load Balancer:** public entry point and target health checking.
* **Amazon EC2 + Auto Scaling Group:** application tier with min = 2, desired = 2, max = 3.
* **Amazon RDS PostgreSQL Multi-AZ:** managed database tier with a synchronous standby in another AZ.
* **Amazon S3:** versioned object storage; the Flask demo does not currently upload/download objects.
* **Amazon CloudWatch:** CPU monitoring; application logs are still local in `app.log` on EC2.
* **Terraform:** Infrastructure as Code for review, repeatability and clean-up.

{{< siteimg src="images/5-Workshop/5.1-workshop-overview/ha-architecture.png" alt="HA architecture" >}}

## 6. Basic security and operations

* AWS Access Key/Secret Key are not hard-coded in the source.
* The RDS password is passed through a Terraform `sensitive` variable; real `terraform.tfvars` and state files are not committed.
* Security Groups follow the **Internet -> ALB -> App -> DB** flow so EC2/RDS do not accept direct public inbound traffic.
* EC2 and RDS are not public in the lab design.
* CloudWatch provides basic monitoring; local application logging and HTTP without TLS are documented limitations.

## 7. Eight-week timeline

| Week | Main work |
|---|---|
| 1 | Kick-off, project selection, template fork, AWS Budgets |
| 2 | Networking, HA theory, architecture diagram, Terraform foundation |
| 3 | Flask demo, user_data, Security Groups, sensitive variable |
| 4 | 2-AZ VPC, RDS Multi-AZ, S3 Versioning |
| 5 | ALB, Target Group, Launch Template, ASG |
| 6 | CloudWatch Alarm, security/limitation review |
| 7 | EC2 termination test, evidence collection, workshop finalization and project submission on 08/08 |
| 8 | Feedback follow-up, website availability and internship wrap-up |

## 8. Budget and cost control

AWS Budgets is configured with a small warning threshold to detect unexpected cost early. It is a **notification threshold**, not a guarantee that total cost will remain below that value. NAT Gateway and RDS Multi-AZ can generate charges, so resources are kept only for the required lab period and cleaned up afterward.

Cost-saving lab choices include `t3.micro`, a shared single NAT Gateway and Terraform-based teardown. `single_nat_gateway = true` is a cost trade-off and not a fully redundant production design.

## 9. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Credential/password exposure | No hard-coded access keys; use CloudShell/CLI profile; do not commit real `terraform.tfvars`/state |
| Direct exposure of EC2/RDS | Private EC2/RDS; Security Groups follow ALB -> App -> DB |
| Single NAT Gateway as a SPOF | Accepted for the lab to reduce cost; production should use an AZ-aware NAT design or another suitable approach |
| Local logs lost with EC2 replacement | Documented limitation; future improvement is CloudWatch Agent/centralized logging |
| No dynamic scaling | Current alarm is monitoring-only; Target Tracking is a future improvement |
| Unexpected cost | AWS Budgets + `terraform destroy` after testing |

## 10. Out of scope in the current version

* No full Workforce business application.
* The Flask demo does not actually connect to/query RDS.
* No RDS failover experiment and no quantitative downtime/error-rate measurement.
* No application-level S3 integration.
* No centralized logging, HTTPS/ACM or dynamic scaling policy.
