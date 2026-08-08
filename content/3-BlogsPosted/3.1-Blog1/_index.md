---
title: "Blog 1 - Proactive cost control with AWS Budgets"
date: 2026-06-24
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---

# From bill anxiety to a FinOps habit: controlling AWS labs with Budgets

When learning AWS, the risk is not only a wrong configuration. It is also very easy to **leave resources running**. A NAT Gateway, RDS instance, or EC2 instance can continue generating cost after the lab is finished.

During the first week of my internship, I configured AWS Budgets as a financial warning layer before building the High Availability architecture.

## The problem

The HA project uses VPC, NAT Gateway, EC2, Application Load Balancer, RDS Multi-AZ, S3, and CloudWatch. These services have different pricing dimensions, so manually checking the Billing Console from time to time is a reactive approach.

## My configuration approach

1. Create a **Monthly Cost Budget**.
2. Choose a small budget suitable for a learning environment.
3. Configure an early alert before the full budget is reached.
4. Register an email recipient.
5. When an alert is received, review Billing/Cost Explorer and remove unnecessary resources.

In my lab, I used a small warning value (for example USD 5) to detect unexpected spending early. This is a **warning threshold**; it does not mean AWS automatically stops all resources at that amount.

## What I learned

* Cost control should be configured **before** provisioning many resources.
* NAT Gateway and RDS Multi-AZ deserve special attention in long-running labs.
* `terraform destroy` is an operational step, not just a cosmetic final command.
* Basic FinOps practices make hands-on experimentation safer and more predictable.

## Recommendation for beginners

AWS Budgets does not replace Pricing documentation or Billing reviews. It works best together with resource tagging, clean-up discipline, and keeping lab resources online only when they are needed.

**Project connection:** I used AWS Budgets to control costs while building the Terraform-based HA lab.

---

**Article created:** 24/06/2026

---

## Sharing information

* **Content created:** 24/06/2026
* **Published:** 08/08/2026
* **Published in:** AWS Study Group VN
* **Status:** Published and approved by the group administrators.

## Evidence

{{< assetimg src="images/3-BlogsPosted/blog1-aws-study-group.png" alt="AWS Budgets post shared in AWS Study Group VN" >}}
