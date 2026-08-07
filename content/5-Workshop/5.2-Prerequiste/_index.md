---
title: "5.2 Prerequisites and environment setup"
date: 2026-08-08
weight: 2
---

## 1. Prerequisites

Prepare:

* An AWS account with permissions to create VPC, EC2, ELB/Target Group, Auto Scaling, RDS, S3, and CloudWatch resources.
* Region: **ap-southeast-1 (Singapore)**.
* Terraform CLI or an AWS CloudShell environment suitable for running Terraform.
* AWS credentials through CloudShell, an AWS CLI profile, or another valid authentication mechanism. **Do not hard-code Access Key/Secret Key values in source code.**
* A browser for AWS Console and ALB endpoint validation.

## 2. Project source

Terraform source for this workshop:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>

Main files:

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

Create a local `terraform.tfvars` from the example and **do not commit the real password**:

```hcl
db_password = "<YOUR_STRONG_PASSWORD>"
```

## 4. Initialize Terraform

From the Terraform source directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Continue only when `terraform validate` succeeds and `terraform plan` shows the expected resources.

## 5. IAM/security for the lab

This workshop does not use a huge `Resource = "*"` policy in the project source. The deployment account/role should only have permissions required by the lab services. EC2 does not currently call S3/Secrets Manager from application code, so the project does not assume an overly broad instance role.
