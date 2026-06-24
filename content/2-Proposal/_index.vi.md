---
title: "Đề xuất Dự án (Proposal)"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

### 1. Tổng quan dự án (Project Overview)
Dự án tập trung vào nghiên cứu và thực nghiệm triển khai một hệ thống hạ tầng có khả năng chống chịu lỗi và đảm bảo tính sẵn sàng cao (High Availability) cho ứng dụng trên nền tảng điện toán đám mây AWS. Hệ thống này mô phỏng một môi trường production thực tế, nơi ứng dụng phải hoạt động liên tục 24/7 ngay cả khi một trung tâm dữ liệu (Availability Zone) gặp sự cố hoàn toàn.

### 2. Vấn đề cần giải quyết (Problem Statement)
* **Rủi ro gián đoạn:** Các hệ thống chạy trên một máy chủ đơn lẻ (Single Point of Failure) rất dễ bị sập khi phần cứng lỗi hoặc gặp sự cố vật lý tại trung tâm dữ liệu.
* **Bài toán quá tải:** Khi lượng người dùng truy cập tăng đột biến, hệ thống không thể tự co giãn băng thông và tài nguyên, dẫn đến nghẽn mạng.
* **Mất mát dữ liệu:** Cơ sở dữ liệu nếu không được đồng bộ theo thời gian thực giữa các phân vùng độc lập sẽ có nguy cơ cao bị mất dữ liệu khi xảy ra sự cố nghiêm trọng.

### 3. Mục tiêu dự án (Objectives)
* Triển khai thành công ứng dụng demo (Python) chạy trên môi trường container hóa (Docker).
* Thiết kế mạng VPC chuẩn doanh nghiệp phân tách giữa Public Subnet và Private Subnet trên Multi-AZ.
* Cấu hình cơ chế tự động cân bằng tải (Application Load Balancer) và tự động co giãn tài nguyên (Auto Scaling Group) theo số lượng request thực tế.
* Triển khai cơ sở dữ liệu có tính năng sao lưu tự động và đồng bộ Multi-AZ (Amazon RDS).
* Thiết lập hệ thống giám sát, thu thập log và cảnh báo tự động thông qua Amazon CloudWatch.

### 4. Kiến trúc giải pháp dự kiến (Solution Architecture)
Hệ thống sử dụng các dịch vụ cốt lõi sau của AWS để hiện thực hóa mô hình HA:
* **Networking:** AWS VPC chia làm 2 Availability Zones độc lập (AZ-A và AZ-B), mỗi AZ bao gồm Public Subnet (chứa Load Balancer) và Private Subnet (chứa EC2 chạy ứng dụng).
* **Compute:** Amazon EC2 Instances chạy ứng dụng Python được quản lý tập trung bởi Auto Scaling Group.
* **Load Balancing:** Application Load Balancer (ALB) tiếp nhận traffic từ internet và phân phối đều xuống các EC2 ở cả 2 AZ.
* **Database:** Amazon RDS (MySQL/PostgreSQL) cấu hình chế độ Multi-AZ nhằm tự động đồng bộ dữ liệu sang AZ dự phòng.
* **Storage:** Amazon S3 dùng để lưu trữ các tài nguyên tĩnh và các tệp đính kèm của ứng dụng.
* **Management & Monitoring:** AWS IAM để quản lý quyền truy cập tối thiểu (Least Privilege) và Amazon CloudWatch để giám sát CPU, RAM, Network.

### 5. Timeline thực hiện rút gọn (5 tuần)
* **Tuần 1:** Thiết kế kiến trúc tổng quan, khởi tạo website báo cáo và viết ứng dụng demo bằng Python.
* **Tuần 2:** Thiết lập môi trường mạng VPC Multi-AZ, khởi tạo RDS, S3 và đóng gói Docker ứng dụng.
* **Tuần 3:** Cấu hình Application Load Balancer (ALB) và Auto Scaling Group (ASG) để hoàn thiện tính năng High Availability.
* **Tuần 4:** Thiết lập hệ thống giám sát Amazon CloudWatch, tiến hành bài thử nghiệm Failover (giả lập sự cố sập AZ) và viết 3 bài blog kỹ thuật chia sẻ.
* **Tuần 5:** Tối ưu hóa chi phí, thắt chặt bảo mật IAM, thực hiện dọn dẹp tài nguyên (Clean-up) để tránh phát sinh chi phí và tổng duyệt báo cáo.

### 6. Ngân sách dự kiến (Budget)
* Sử dụng hoàn toàn trong phạm vi gói tài khoản **AWS Free Tier** kết hợp với khoản **$200 Credit** được chương trình First Cloud Journey cấp.
* Thiết lập AWS Budgets để cảnh báo ngay lập tức nếu chi phí vượt ngưỡng $5.

### 7. Rủi ro và Biện pháp giảm thiểu (Risks & Mitigations)
* **Rủi ro:** Cấu hình sai Security Group hoặc IAM Role dẫn đến việc lộ lọt dữ liệu hoặc tài nguyên bị hack công khai.
* **Biện pháp:** Áp dụng nghiêm ngặt nguyên tắc trao quyền tối thiểu (Principle of Least Privilege), không mở public các tài nguyên trong Private Subnet (như EC2 và RDS) và tuyệt đối không hard-code các khóa bảo mật (Access Keys).
