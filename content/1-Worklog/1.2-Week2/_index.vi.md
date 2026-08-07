---
title: "Worklog Tuần 2"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---

### Thời gian

**29/06/2026 - 05/07/2026**

### Công việc đã thực hiện / kế hoạch

* Nghiên cứu Amazon VPC, public/private/database subnet, Internet Gateway, NAT Gateway và Security Group.
* Tìm hiểu cách ALB, Target Group, Auto Scaling Group và RDS Multi-AZ phối hợp để giảm Single Point of Failure.
* Phác thảo sơ đồ kiến trúc 3-Tier trên 2 Availability Zones và xác định luồng User -> ALB -> EC2 -> RDS.
* Làm quen Terraform/HCL, provider AWS, biến cấu hình và cách quản lý state ở mức lab.

### Kết quả

* Hoàn thiện bản thiết kế kiến trúc tổng thể.
* Xác định nguyên tắc network isolation: ALB public, EC2 private, RDS database subnet.
* Có nền tảng Terraform để bắt đầu triển khai hạ tầng từ tuần tiếp theo.
