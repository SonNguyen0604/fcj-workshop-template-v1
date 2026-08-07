---
title: "Worklog Tuần 3"
date: 2026-06-22
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---

### Thời gian

**06/07/2026 - 12/07/2026**

### Công việc đã thực hiện / kế hoạch

* Xây dựng ứng dụng web demo bằng Python/Flask để làm workload kiểm thử cho hạ tầng HA.
* Viết user_data để EC2 tự cài Python/Flask, tạo app.py và khởi chạy dịch vụ khi instance boot.
* Tạo biến db_password ở dạng sensitive, tránh hard-code mật khẩu trực tiếp trong resource RDS.
* Bắt đầu khai báo Terraform cho VPC, subnet và các Security Group ALB/App/DB.

### Kết quả

* Flask demo có thể trả về hostname của EC2 và hiển thị endpoint RDS được Terraform truyền vào.
* Bộ khung Terraform đã hình thành và tách rõ luồng truy cập giữa các tầng.
* Không lưu access key hoặc password thật trực tiếp trong source code.
