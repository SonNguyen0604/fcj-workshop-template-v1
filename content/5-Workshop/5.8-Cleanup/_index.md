---
title: "5.8 Clean-up"
date: 2026-08-08
weight: 8
---

## Why clean up?

NAT Gateway and RDS Multi-AZ can continue generating cost after the lab is finished. Because the infrastructure is managed by Terraform, clean-up should be performed from the same source/state used for deployment.

## Step 1 - Review the destroy plan

```bash
terraform plan -destroy
```

Review the resources scheduled for deletion before continuing.

## Step 2 - Destroy the infrastructure

```bash
terraform destroy --auto-approve
```

The expected result is that Terraform removes the resources managed by state and returns `Destroy complete!` when finished.

## Step 3 - Verify in AWS Console

After destroy, check:

* EC2/Auto Scaling Group;
* Application Load Balancer/Target Group;
* RDS;
* NAT Gateway and VPC;
* S3 bucket;
* CloudWatch Alarm.

If the bucket contains objects/versions or resources were created manually outside Terraform, they may require separate review/cleanup.

## Lab note

`skip_final_snapshot = true` and `force_destroy = true` are used for convenient teardown in this disposable lab. Do not copy these settings to production without an appropriate backup/data-retention policy.

> Save the screenshots/logs/evidence required for project evaluation before cleaning up the lab.
