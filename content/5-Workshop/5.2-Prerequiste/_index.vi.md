---
title: "5.2 Prerequisites và chuẩn bị môi trường"
date: 2026-08-08
weight: 2
---

## 1. Prerequisites

Cần chuẩn bị:

* AWS account có quyền tạo VPC, EC2, ELB/Target Group, Auto Scaling, RDS, S3 và CloudWatch.
* Region: **ap-southeast-1 (Singapore)**.
* Terraform CLI hoặc AWS CloudShell có môi trường phù hợp để chạy Terraform.
* AWS credentials thông qua CloudShell, AWS CLI profile hoặc cơ chế đăng nhập hợp lệ. **Không hard-code Access Key/Secret Key vào source.**
* Trình duyệt để truy cập AWS Console và kiểm tra ALB endpoint.

## 2. Source project

Source Terraform của workshop:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>

Các file chính:

```text
terraform/
├── main.tf
├── terraform.tfvars.example
└── README.md
```

## 3. Chuẩn bị biến mật khẩu RDS

`main.tf` khai báo:

```hcl
variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for the PostgreSQL RDS database"
}
```

Tạo file `terraform.tfvars` từ file mẫu và **không commit file chứa mật khẩu thật**:

```hcl
db_password = "<YOUR_STRONG_PASSWORD>"
```

## 4. Khởi tạo Terraform

Tại thư mục chứa source:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Chỉ tiếp tục khi `terraform validate` không báo lỗi và `terraform plan` hiển thị đúng các resource dự kiến.

## 5. Bảo mật/IAM ở mức lab

Workshop không tạo một IAM policy `Resource = "*"` khổng lồ trong source. Tài khoản/role dùng để deploy chỉ nên có quyền cần thiết cho các service của lab. EC2 hiện chưa gọi S3/Secrets Manager từ ứng dụng nên project không giả định một instance role quyền rộng.
