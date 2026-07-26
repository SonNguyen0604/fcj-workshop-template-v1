---
title: "5.7 Resource Clean-up"
date: 2026-07-27T10:40:00+07:00
weight: 7
---

### Cost Optimization and Resource Teardown

Upon successfully deploying the system, recording the demo, and capturing test evidence, the most crucial step in a hands-on Cloud lab is cleaning up resources to prevent unexpected billing charges (especially for NAT Gateway and RDS Multi-AZ).

Because the entire infrastructure was provisioned using **Infrastructure as Code (IaC) via Terraform**, the teardown process was extremely safe and efficient.

By executing a single command:
```bash
terraform destroy --auto-approve

Terraform automatically calculated the dependency graph and dismantled all resources (VPC, ALB, ASG, EC2, RDS) cleanly.

(Insert your Terminal screenshot showing the successful execution of terraform destroy with the "Destroy complete!" message here)
![Terraform Destroy](/images/terraform-destroy.png)
