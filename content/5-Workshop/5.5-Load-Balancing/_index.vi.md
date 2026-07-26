---
title: "5.5 Load Balancing (ALB)"
date: 2026-07-27T10:20:00+07:00
weight: 5
---

### Phân phối lưu lượng với Application Load Balancer

Do ứng dụng được đặt trong Private Subnets và có thể thay đổi số lượng máy ảo liên tục (nhờ Auto Scaling), người dùng không thể truy cập trực tiếp vào các EC2 instances. Do đó, một **Application Load Balancer (ALB)** được đặt ở Public Subnets đóng vai trò là điểm truy cập duy nhất (Single Entry Point).

ALB thực hiện các nhiệm vụ:
1.  **Phân tải (Traffic Routing):** Chia đều lưu lượng truy cập của người dùng đến các EC2 instances khỏe mạnh (Healthy targets) đang nằm rải rác ở 2 AZs.
2.  **Health Check:** Liên tục gửi request đến endpoint `/health/ready` của ứng dụng. Nếu một máy ảo trả về lỗi (ví dụ: HTTP 500) hoặc timeout, ALB sẽ ngừng gửi traffic đến máy ảo đó để đảm bảo người dùng không gặp gián đoạn.

<img width="1895" height="908" alt="image" src="https://github.com/user-attachments/assets/5a3f549e-81e5-4f54-9a92-aaab04e2d60a" />
<img width="1900" height="903" alt="image" src="https://github.com/user-attachments/assets/9d9627a9-24c7-4f89-9f25-7997452a32db" />
`![ALB Target Group](/images/alb-target-group.png)`
