---
title: "5.8 Clean-up"
date: 2026-08-08
weight: 8
---

## Vì sao phải clean-up?

NAT Gateway và RDS Multi-AZ có thể tiếp tục phát sinh chi phí khi lab đã kết thúc. Vì toàn bộ hạ tầng được quản lý bằng Terraform, clean-up nên được thực hiện từ cùng source/state đã dùng để deploy.

## Bước 1 - Kiểm tra trước khi xóa

```bash
terraform plan -destroy
```

Rà soát danh sách resource dự kiến bị xóa trước khi tiếp tục.

## Bước 2 - Xóa hạ tầng

```bash
terraform destroy --auto-approve
```

Kết quả mong đợi là Terraform xóa các resource do state quản lý và trả về `Destroy complete!` khi hoàn tất.

## Bước 3 - Kiểm tra AWS Console

Sau destroy, kiểm tra lại:

* EC2/Auto Scaling Group;
* Application Load Balancer/Target Group;
* RDS;
* NAT Gateway và VPC;
* S3 bucket;
* CloudWatch Alarm.

Nếu bucket có object/version hoặc có resource được tạo thủ công ngoài Terraform, cần kiểm tra/xử lý riêng.

## Lưu ý lab

`skip_final_snapshot = true` và `force_destroy = true` được dùng để thuận tiện teardown trong môi trường thực nghiệm. Không nên sao chép nguyên cấu hình này sang production nếu chưa có chính sách backup/data retention phù hợp.

> Trước khi clean-up, cần lưu lại đầy đủ ảnh/log/evidence phục vụ đánh giá project.
