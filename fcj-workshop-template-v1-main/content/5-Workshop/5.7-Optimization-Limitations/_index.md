---
title: "5.7 Optimization, security and limitations"
date: 2026-08-08
weight: 7
---

## Lab cost optimization

* Use `t3.micro` for EC2 and `db.t3.micro` for RDS to match the demo scale.
* Use `single_nat_gateway = true` to reduce NAT cost; this is a trade-off and leaves a shared dependency.
* Use AWS Budgets for early cost warnings.
* Keep NAT Gateway/RDS Multi-AZ only as long as testing requires and clean up with Terraform afterward.

## Basic security

* Do not hard-code AWS Access Key/Secret Key in source code.
* Pass the RDS password through a `sensitive` variable; do not commit real `terraform.tfvars` or Terraform state.
* `alb-sg` is the public inbound layer; `app-sg` only accepts traffic from ALB; `db-sg` only accepts PostgreSQL traffic from the application tier.
* EC2 and RDS are not designed for direct Internet access.

## Current limitations

| Limitation | Impact | Improvement |
|---|---|---|
| Single NAT Gateway | Network SPOF is not fully removed | NAT per AZ or an architecture with less NAT dependency |
| HTTP port 80 | Client-to-ALB traffic is not encrypted | ACM + HTTPS listener/HTTP-to-HTTPS redirect |
| Flask only displays the RDS endpoint | No DB query/retry evidence | Real PostgreSQL connection + pool/retry |
| S3 not integrated with the application | No real object workflow | Least-privilege IAM role + upload/download/presigned URL |
| Local `app.log` | Logs may be lost when EC2 is terminated | CloudWatch Agent/CloudWatch Logs |
| RDS failover not tested | No DB-tier recovery evidence | Reboot with failover + probe + data validation |
| No downtime/error-rate measurement | No quantitative HA KPI | Probe script/k6/Locust with p95/error-rate metrics |
| No dynamic scaling | ASG only self-heals/maintains capacity | Target Tracking using CPU or ALB request metrics |

## Key point

The project focuses on **basic HA and application-tier self-healing**. Explicitly documenting limitations is part of the technical evaluation and avoids presenting unimplemented items as completed features.
