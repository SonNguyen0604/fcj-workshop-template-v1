---
title: "Bài viết kỹ thuật (Blogs)"
date: 2026-06-24
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

Trong kỳ thực tập, tôi biên soạn **3 bài viết kỹ thuật** gắn trực tiếp với project High Availability. Các bài được lưu ngay trên workshop cá nhân để hệ thống hóa kiến thức và ghi lại những gì tôi đã cấu hình/nghiên cứu trong quá trình làm lab.

Mục này chỉ ghi **ngày tạo/hoàn thiện nội dung** của từng bài.

> Ba bài dưới đây là **bài viết kỹ thuật được tạo trên website workshop cá nhân**. Tôi chỉ ghi ngày tạo nội dung; không ghi nhận là bài đã đăng công khai.

## [Blog 1 - Quản lý chi phí chủ động với AWS Budgets](3.1-blog1/)

* **Ngày tạo:** 24/06/2026.
* **Chủ đề:** Cost control/FinOps cơ bản cho tài khoản lab.
* **Liên hệ project:** Kiểm soát chi phí trước khi triển khai NAT Gateway, EC2, ALB và RDS Multi-AZ.

## [Blog 2 - ALB + Auto Scaling Group: xây dựng tầng ứng dụng tự phục hồi](3.2-blog2/)

* **Ngày tạo:** 08/08/2026.
* **Chủ đề:** Health check, Desired Capacity, self-healing và sự khác nhau giữa duy trì capacity với dynamic scaling.
* **Liên hệ project:** EC2 terminate -> Target Group unhealthy -> ASG tạo instance thay thế.

## [Blog 3 - RDS Multi-AZ + CloudWatch: tăng khả năng phục hồi và quan sát hệ thống](3.3-blog3/)

* **Ngày tạo:** 08/08/2026.
* **Chủ đề:** Multi-AZ database, monitoring, alarm và giới hạn observability của bản demo.
* **Liên hệ project:** Phân biệt phần đã cấu hình với phần chưa thực nghiệm như RDS failover và centralized logging.
