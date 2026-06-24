---
title: "Bài viết Blogs"
date: 2026-06-24
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

Trong suốt quá trình thực tập và triển khai dự án hạ tầng High Availability tại AWS Vietnam, tôi thực hiện nghiên cứu, đúc kết thực nghiệm và biên soạn các bài viết chuyên sâu. Chuỗi bài viết này nhằm chia sẻ kiến thức cốt lõi, lan tỏa giải pháp công nghệ đám mây và ghi lại các cột mốc trưởng thành kỹ thuật của bản thân.

---

## [BÀI BLOG 1: Từ Nỗi Sợ "Hóa Đơn Khủng" Đến Vùng An Toàn Cloud: Quản Lý Chi Phí Chủ Động Với AWS Budgets](3.1-Blog1/)

* **Trạng thái:** Đã đăng vào Tuần 1 (Ngày 24/06/2026).
* **Nội dung chính:**
  * Phân tích bài toán quản trị chi phí đám mây (FinOps) dành cho sinh viên và thực tập sinh khi làm Lab thực tế trên AWS.
  * Hướng dẫn tư duy thiết lập "vòng an toàn" chủ động thông qua các ngưỡng cảnh báo thông minh (Alert Thresholds) thay vì kiểm tra thủ công bị động.
  * Minh chứng cấu hình thực tế bộ kiểm soát dòng tiền ở ngưỡng $5.00/tháng, tạo tâm lý tự tin thử nghiệm hạ tầng lớn mà không lo rủi ro tài chính.

---

## BÀI BLOG 2: Tối Ưu Hóa Hạ Tầng Tự Động Co Giãn Với Application Load Balancer Và Auto Scaling Group

* **Trạng thái:** Dự kiến đăng vào Tuần 5 (Giai đoạn cấu hình Load Balancer & Auto Scaling).
* **Nội dung chính:**
  * Giới thiệu về Application Load Balancer (ALB): Cơ chế điều phối lưu lượng, kiểm tra sức khỏe hệ thống (Health Checks) và phân phối thông minh request để loại bỏ điểm lỗi đơn lẻ (SPOF).
  * Sức mạnh của AWS Auto Scaling Group (ASG): Cách thiết lập các chính sách co giãn tự động (Scaling Policies) linh hoạt theo CPU Utilization hoặc Request Count.
  * Sự kết hợp hoàn hảo giữa ALB và ASG giúp hệ thống đạt năng lực tự chữa lành (Self-healing) và tối ưu hóa chi phí vận hành cho doanh nghiệp.

---

## BÀI BLOG 3: Bảo Mật Dữ Liệu Multi-AZ Với Amazon RDS Và Giám Sát Tập Trung Bằng Amazon CloudWatch

* **Trạng thái:** Dự kiến đăng vào Tuần 6 (Giai đoạn tối ưu hóa giám sát nâng cao).
* **Nội dung chính:**
  * Giải pháp lưu trữ bền vững với Amazon RDS Multi-AZ: Cơ chế đồng bộ hóa dữ liệu theo thời gian thực (Synchronous Replication) sang vùng dự phòng (Standby DB).
  * Quy trình tự động chuyển vùng sự cố (Automated Failover) giúp ứng dụng duy trì kết nối liên tục 24/7 ngay cả khi một trung tâm dữ liệu gặp thảm họa vật lý.
  * Thiết lập Dashboard giám sát toàn diện và cấu hình CloudWatch Alarms để chủ động bắt bệnh hệ thống, tự động gửi mail cảnh báo cho kỹ sư vận hành.
