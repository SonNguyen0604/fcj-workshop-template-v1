---
title: "Worklog Tuần 6"
date: 2026-07-27
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---

### Thời gian

**27/07/2026 - 02/08/2026**

### Công việc đã thực hiện / kế hoạch

* Cấu hình CloudWatch Metric Alarm theo dõi CPUUtilization của nhóm máy chủ.
* Rà soát lại sự khác nhau giữa monitoring alarm và dynamic scaling policy; không tuyên bố alarm hiện tại tự scale theo CPU.
* Kiểm tra application log được ghi tại app.log trên EC2 và ghi nhận giới hạn chưa có centralized logging/CloudWatch Agent.
* Rà soát Terraform, tên resource, S3 Versioning, ELB health check và các giới hạn của môi trường demo.

### Kết quả

* Có CloudWatch Alarm phục vụ giám sát CPU.
* Tài liệu kỹ thuật được đồng bộ với những gì hạ tầng thực sự triển khai.
* Các limitation được ghi rõ thay vì mô tả quá mức kết quả.
