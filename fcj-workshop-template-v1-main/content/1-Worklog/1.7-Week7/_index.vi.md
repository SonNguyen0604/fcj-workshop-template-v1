---
title: "Worklog Tuần 7"
date: 2026-08-03
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Thời gian

**03/08/2026 - 09/08/2026**

### Công việc đã thực hiện

* Thực hiện kịch bản terminate một EC2 đang thuộc Auto Scaling Group.
* Quan sát Target Group loại target lỗi sau các health check và ASG tạo instance thay thế để khôi phục Desired Capacity.
* Thu thập ảnh minh chứng từ Terraform/AWS Console, ứng dụng web, EC2 và CloudWatch.
* Hoàn thiện 3 bài viết kỹ thuật trên website, cập nhật thông tin và ảnh minh chứng cho 3 sự kiện đã tham gia.
* Rà soát song ngữ Việt/Anh, source Terraform, các link/ảnh và các giới hạn kỹ thuật để nội dung website khớp với hệ thống thực tế.
* Hoàn thiện project/workshop để **nộp ngày 08/08/2026**.

### Kết quả

* Chứng minh được self-healing ở tầng ứng dụng khi một EC2 bị terminate.
* Có bằng chứng trực quan cho Terraform validation, ALB/Flask, EC2 replacement và CloudWatch Alarm.
* Website có đủ các phần Worklog, Proposal, Blogs, Events, Workshop, Self-evaluation và Feedback bằng hai ngôn ngữ.
* Các phần chưa thực hiện như RDS failover, downtime/error-rate measurement, centralized logging và dynamic scaling được ghi rõ thay vì khẳng định quá mức.
* Project kỹ thuật và workshop đạt trạng thái sẵn sàng nộp ngày **08/08/2026**.
