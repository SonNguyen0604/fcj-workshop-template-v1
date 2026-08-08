---
title: "5.2 Prerequisites and environment setup"
date: 2026-08-08
weight: 2
---

## 1. Prerequisites

Prepare:

* An AWS account with permissions to create VPC, EC2, ELB/Target Group, Auto Scaling, RDS, S3 and CloudWatch resources.
* Region: **ap-southeast-1 (Singapore)**.
* Terraform CLI or AWS CloudShell with a suitable Terraform environment.
* AWS credentials through CloudShell, an AWS CLI profile or another valid authentication method. **Do not hard-code Access Key/Secret Key in source code.**
* A browser for AWS Console and ALB endpoint validation.

## 2. Project source

Terraform source used in the workshop:

* [main.tf](/files/terraform/main.tf)
* [terraform.tfvars.example](/files/terraform/terraform.tfvars.example)
* [README](/files/terraform/README.md)

Structure:

```text
terraform/
├── main.tf
├── terraform.tfvars.example
└── README.md
```

## 3. Prepare the RDS password variable

`main.tf` declares:

```hcl
variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for the PostgreSQL RDS database"
}
```

Create `terraform.tfvars` from the example and **do not commit the real password**:

```hcl
db_password = "<YOUR_STRONG_PASSWORD>"
```

> `sensitive = true` hides the value from some CLI output, but it **does not encrypt secrets in Terraform state**. Real `terraform.tfstate`, `terraform.tfvars` and credentials must not be committed to GitHub.

## 4. Initialize and validate Terraform

From the source directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Continue only when `terraform validate` succeeds and `terraform plan` shows the expected resources.

## 5. Deploy the infrastructure

```bash
terraform apply
```

Confirm with `yes` when the plan is correct. After apply, obtain the ALB endpoint with:

```bash
terraform output Link_Truy_Cap_Web
```

If the infrastructure already exists and state/configuration are unchanged, `terraform apply` may return `No changes`. This is a valid configuration consistency check.

## 6. IAM/security scope for the lab

The workshop does not embed access keys and does not create a broad `Resource = "*"` IAM policy in the source. The deployment identity should only have the permissions required for the lab services. EC2 does not currently call S3/Secrets Manager from the application, so the project does not assume a broad instance role.
