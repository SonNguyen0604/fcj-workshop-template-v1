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

Source Terraform dùng trong workshop:

* [main.tf](/files/terraform/main.tf)
* [terraform.tfvars.example](/files/terraform/terraform.tfvars.example)
* [README](/files/terraform/README.md)

Cấu trúc:

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

Tạo `terraform.tfvars` từ file mẫu và **không commit file chứa mật khẩu thật**:

```hcl
db_password = "<YOUR_STRONG_PASSWORD>"
```

> `sensitive = true` giúp che giá trị trong một số output CLI, nhưng **không mã hóa secret trong Terraform state**. Vì vậy `terraform.tfstate`, `terraform.tfvars` và credential thật không được đưa lên GitHub.

## 4. Khởi tạo và kiểm tra Terraform

Tại thư mục chứa source:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Chỉ tiếp tục khi `terraform validate` không báo lỗi và `terraform plan` hiển thị đúng các resource dự kiến.

## 5. Triển khai hạ tầng

```bash
terraform apply
```

Xác nhận bằng `yes` nếu plan đúng. Sau khi apply, lấy endpoint ALB bằng:

```bash
terraform output Link_Truy_Cap_Web
```

Nếu hạ tầng đã tồn tại và state/configuration không thay đổi, `terraform apply` có thể trả về `No changes`. Đây là kết quả hợp lệ khi kiểm tra tính đồng nhất của cấu hình.

## 6. IAM/bảo mật ở mức lab

Workshop không nhúng access key và không tạo một IAM policy quyền rộng `Resource = "*"` trong source. Identity dùng để deploy nên chỉ có quyền cần thiết cho các service của lab. EC2 hiện chưa gọi S3/Secrets Manager từ ứng dụng, vì vậy project không giả định một instance role quyền rộng.
