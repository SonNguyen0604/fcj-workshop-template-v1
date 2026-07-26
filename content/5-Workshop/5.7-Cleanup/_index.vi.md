---
title: "5.7 Clean-up (Dọn dẹp)"
date: 2026-07-27T10:40:00+07:00
weight: 7
---

### Tối ưu chi phí và dọn dẹp tài nguyên

Sau khi hoàn thành việc triển khai, quay video demo và chụp lại các bằng chứng kiểm thử, việc quan trọng nhất đối với một hệ thống Cloud thực hành là dọn dẹp tài nguyên để tránh phát sinh chi phí ngoài ý muốn (đặc biệt là với NAT Gateway và RDS Multi-AZ).

Do toàn bộ hệ thống được tôi xây dựng dưới dạng **Infrastructure as Code (IaC) thông qua Terraform**, việc dọn dẹp diễn ra vô cùng an toàn và nhanh chóng.

Chỉ với một câu lệnh:
```bash
terraform destroy --auto-approve

Terraform đã tự động tính toán dependency graph và tháo gỡ toàn bộ tài nguyên (VPC, ALB, ASG, EC2, RDS) một cách sạch sẽ.

(Chèn ảnh chụp màn hình Terminal chạy thành công lệnh terraform destroy hiển thị dòng chữ "Destroy complete!" vào đây)
![Terraform Destroy](/images/terraform-destroy.png)
