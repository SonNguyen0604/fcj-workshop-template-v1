---
title: "5.6 Testing and validation"
date: 2026-08-08
weight: 6
---

## Test 1 - Terraform validation

Run:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

During the final check, `terraform apply` returned `No changes` because the existing infrastructure matched Terraform state/configuration. This confirms configuration consistency; it **does not prove that resources were created from scratch in that run**.

![Terraform validation](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/terraform-validation.png)

## Test 2 - Inbound traffic through the ALB

Get the ALB DNS name:

```bash
terraform output Link_Truy_Cap_Web
```

Open the DNS name in a browser. Observed result:

* The Flask demo returns HTTP 200 through the ALB.
* The page displays the hostname of the EC2 instance processing the request.
* The page displays the RDS endpoint injected by Terraform.

![ALB web validation](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/alb-web-validation.png)

> Displaying the endpoint **does not mean the application connected to or queried RDS**.

## Test 3 - Terminate one EC2 instance

1. Confirm the ASG has `Desired Capacity = 2`.
2. Select one EC2 instance managed by the ASG and terminate it.
3. Observe the Target Group; the failed target becomes unhealthy after failing the configured health checks.
4. Observe Auto Scaling Activity/EC2; when actual capacity drops below Desired Capacity, the ASG launches a replacement instance.
5. Wait for the new instance to register with the Target Group and become healthy.

![EC2 replacement](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/ec2-replacement.png)

### Observed result

The ASG launched a new instance and restored the configured server count. The project **did not measure exact downtime, error rate or recovery time**, so this test is evaluated qualitatively rather than claiming a fixed recovery time.

## Test 4 - CloudWatch Alarm

Open the CloudWatch Alarm and verify that the alarm exists, the CPU metric is displayed and the state is updated.

![CloudWatch CPU Alarm](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/cloudwatch-alarm.png)

The alarm is **monitoring-only**; there is no CPU-based scaling policy.

## Validation summary

| Objective | Action | Observed result | Status |
|---|---|---|---|
| Terraform config/state consistency | `terraform validate/plan/apply` | `No changes`, ALB DNS output | **Pass** |
| User -> ALB -> Flask | Open ALB DNS | HTTP 200 and EC2 hostname displayed | **Pass** |
| EC2 self-healing | Terminate 1 ASG EC2 | ASG launches a replacement and restores Desired Capacity | **Pass** |
| CPU monitoring | Open CloudWatch Alarm | Alarm and CPU metric displayed | **Pass** |
| RDS failover | No failover test performed | No experimental data | **Not tested** |
| Downtime/error rate | No probe/load test | No quantitative data | **Not measured** |
| Load-based dynamic scaling | No scaling policy | Alarm is monitoring-only | **Not implemented** |
| Centralized application logging | Logs remain in local `app.log` | Logs may be lost on instance replacement | **Not implemented** |
