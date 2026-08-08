---
title: "Bài viết kỹ thuật (Blogs)"
date: 2026-08-08
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

Trong kỳ thực tập, tôi biên soạn **3 bài viết kỹ thuật** gắn trực tiếp với project High Availability trên AWS. Nội dung các bài được xây dựng từ những phần tôi đã nghiên cứu, cấu hình và kiểm thử trong quá trình làm lab.

Ngày **08/08/2026**, cả 3 bài đã được chia sẻ trên **AWS Study Group VN** và được quản trị viên phê duyệt.

{{< assetimg src="images/3-BlogsPosted/blogs-approved.png" alt="Thông báo ba bài blog đã được phê duyệt trên AWS Study Group VN" >}}

## [Blog 1 - Quản lý chi phí chủ động với AWS Budgets](3.1-blog1/)

* **Ngày tạo:** 24/06/2026.
* **Ngày đăng:** 08/08/2026.
* **Chủ đề:** Cost control/FinOps cơ bản cho tài khoản lab.
* **Liên hệ project:** Kiểm soát chi phí trước và trong quá trình triển khai NAT Gateway, EC2, ALB và RDS Multi-AZ.

## [Blog 2 - ALB + Auto Scaling Group: xây dựng tầng ứng dụng tự phục hồi](3.2-blog2/)

* **Ngày tạo:** 08/08/2026.
* **Ngày đăng:** 08/08/2026.
* **Chủ đề:** Health check, Desired Capacity, self-healing và sự khác nhau giữa duy trì capacity với dynamic scaling.
* **Liên hệ project:** EC2 terminate -> Target Group unhealthy -> ASG tạo instance thay thế.

## [Blog 3 - RDS Multi-AZ + CloudWatch: tăng khả năng phục hồi và quan sát hệ thống](3.3-blog3/)

* **Ngày tạo:** 08/08/2026.
* **Ngày đăng:** 08/08/2026.
* **Chủ đề:** Multi-AZ database, monitoring, alarm và giới hạn observability của bản demo.
* **Liên hệ project:** Phân biệt phần đã cấu hình với phần chưa thực nghiệm như RDS failover và centralized logging.
