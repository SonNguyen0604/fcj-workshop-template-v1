---
title: "Worklog Tuần 4"
date: 2026-06-22
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---

### Thời gian

**13/07/2026 - 19/07/2026**

### Công việc đã thực hiện / kế hoạch

* Triển khai VPC 10.0.0.0/16 với 6 subnet trên ap-southeast-1a và ap-southeast-1b.
* Cấu hình một NAT Gateway cho môi trường lab nhằm giảm chi phí, đồng thời ghi nhận đây là trade-off về HA.
* Triển khai RDS PostgreSQL với multi_az = true và database subnet group riêng.
* Khởi tạo S3 bucket và bật Versioning; cấu hình Security Group DB chỉ cho phép kết nối từ app-sg.

### Kết quả

* Hoàn thành tầng Network và Data cho kiến trúc 3-Tier.
* RDS được đặt trong database subnet và không public trực tiếp.
* S3 được tách khỏi vòng đời EC2, tuy chưa tích hợp upload/download từ Flask demo.
