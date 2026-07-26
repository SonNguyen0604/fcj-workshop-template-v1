---
title: "5.4 Compute & Auto Scaling"
date: 2026-07-27T10:10:00+07:00
weight: 4
---

### 1. Cấu hình Launch Template

Để đảm bảo mọi máy ảo (EC2) khi được tạo ra đều có cấu hình giống hệt nhau (Stateless), tôi sử dụng **Launch Template**. Trong Launch Template này, tôi cấu hình:
*   **AMI:** Amazon Linux 2023.
*   **Instance Type:** t2.micro hoặc t3.micro (phù hợp với môi trường lab).
*   **User Data:** Chứa script tự động cài đặt Docker, kéo image ứng dụng Python (FastAPI) về và khởi chạy container ngay khi máy ảo vừa boot xong.

### 2. Thiết lập Auto Scaling Group (ASG)

Điểm cốt lõi của tính sẵn sàng cao ở tầng ứng dụng (Application Tier) nằm ở **Auto Scaling Group**. Tôi cấu hình ASG với các thông số:
*   **Phân bổ:** Trải rộng trên 2 Private Subnets ở 2 AZs khác nhau.
*   **Capacity:** Min = 2, Desired = 2, Max = 4. 
*   **Cơ chế tự phục hồi (Self-healing):** ASG liên tục kiểm tra trạng thái (Health Check) của các EC2 instances. Nếu phát hiện một instance bị lỗi, ASG sẽ tự động hủy (terminate) nó và tạo ra một instance mới từ Launch Template để thay thế.

<img width="1893" height="868" alt="image" src="https://github.com/user-attachments/assets/49202059-d916-4af0-aa2f-289663fcffc4" />
`![Auto Scaling Group](/images/asg-setup.png)`
