---
title: "Worklog Tuần 7"
date: 2026-06-22
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Thời gian

**03/08/2026 - 09/08/2026**

### Công việc đã thực hiện / kế hoạch

* Thực hiện kịch bản terminate một EC2 đang thuộc Auto Scaling Group.
* Quan sát Target Group đánh dấu target lỗi sau các health check và ASG tạo instance thay thế để khôi phục Desired Capacity.
* Thu thập ảnh minh chứng từ AWS Console, ứng dụng web và CloudWatch để đưa vào báo cáo/workshop.
* Hoàn thiện báo cáo thực tập, rà soát lại các tuyên bố về RDS, CloudWatch, S3 và failover để đảm bảo trung thực.

### Kết quả

* Chứng minh được self-healing ở tầng ứng dụng khi một EC2 bị terminate.
* Có bằng chứng trực quan cho ALB/ASG/CloudWatch và ứng dụng demo.
* Chưa đo downtime/error rate và chưa thực nghiệm RDS failover; các giới hạn này được ghi rõ.
