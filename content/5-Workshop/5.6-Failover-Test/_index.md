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

During a final verification, `terraform apply` may return `No changes` when the deployed infrastructure already matches Terraform state/configuration. This proves consistency; it does not mean the screenshot shows a fresh deployment from zero.

## Test 2 - Inbound traffic through ALB

Get the DNS name from Terraform output:

```hcl
output "Link_Truy_Cap_Web" {
  value = aws_lb.app_alb.dns_name
}
```

Open the DNS name in a browser. Expected result:

* HTTP 200 from the Flask demo.
* The page displays the hostname of the EC2 instance serving the request.
* The page displays the RDS endpoint configuration injected by Terraform.

Displaying the endpoint **does not mean the application queried RDS**.

## Test 3 - Terminate one EC2 instance

1. Confirm the ASG has `Desired Capacity = 2`.
2. Terminate one EC2 instance managed by the ASG.
3. Observe the Target Group. After the target fails the configured health checks, it becomes unhealthy.
4. Observe Auto Scaling Activity/EC2. When actual capacity drops below Desired Capacity, the ASG launches a replacement.
5. Wait for the new instance to register in the Target Group and become healthy.

<img width="1888" height="922" alt="EC2 replacement" src="https://github.com/user-attachments/assets/6f2398dc-1061-42c0-a056-7b8e9e3d95a4" />
<img width="1893" height="893" alt="CloudWatch/ASG evidence" src="https://github.com/user-attachments/assets/1071fb9f-261c-4a4c-bbe0-32a75df7fda7" />

### Observed result

The ASG launched a new instance to restore the configured capacity. The project **did not measure exact downtime, error rate, or recovery time**, so failover is evaluated qualitatively rather than against a fixed recovery-time claim.

## Test 4 - CloudWatch

Open the CloudWatch Alarm and verify that the alarm exists, CPU metrics are visible, and the state is updated. The current alarm is monitoring-only.

## Summary

| Test | Result |
|---|---|
| Terraform state/config validation | Pass |
| ALB -> Flask demo | Pass |
| EC2 termination -> ASG replacement | Pass |
| CloudWatch CPU monitoring | Pass |
| RDS failover | Not tested |
| Downtime/error-rate measurement | Not tested |
| CPU-based dynamic scaling | Not implemented |
| Centralized application logging | Not implemented |
