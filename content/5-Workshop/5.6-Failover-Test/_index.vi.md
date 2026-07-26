---
title: "5.6 Kiểm thử tự phục hồi (Failover Test)"
date: 2026-07-27T10:30:00+07:00
weight: 6
---

### Kịch bản thực nghiệm: Mô phỏng sự cố sập máy chủ

Để chứng minh kiến trúc thực sự đạt chuẩn High Availability, tôi đã thực hiện một kịch bản kiểm thử chủ động gây lỗi (Chaos Engineering cơ bản).

**Các bước thực hiện:**
1.  Truy cập vào giao diện EC2 Console, chọn ngẫu nhiên 1 máy ảo đang chạy ứng dụng và thực hiện lệnh **Terminate** (Mô phỏng trường hợp máy chủ bị hỏng phần cứng hoặc crash hệ điều hành).
2.  Ngay lập tức, **Application Load Balancer** phát hiện Target bị lỗi thông qua Health Check và tự động chuyển toàn bộ request của người dùng sang máy ảo còn lại ở AZ thứ 2. Hệ thống vẫn tiếp tục phục vụ mà không bị gián đoạn hoàn toàn (Zero Downtime for active connections if handled gracefully).
3.  Sau khoảng 1-2 phút, **Auto Scaling Group** phát hiện Desired Capacity (2) không khớp với số lượng thực tế (1). Nó ngay lập tức kích hoạt Launch Template để tạo ra một máy ảo EC2 hoàn toàn mới thay thế cho máy vừa chết.

<img width="1888" height="922" alt="image" src="https://github.com/user-attachments/assets/3a2eab26-9fa7-4726-a82a-3e06555a220a" />
<img width="1889" height="920" alt="image" src="https://github.com/user-attachments/assets/5eff9ea4-371e-4571-b7fd-b4a04c7f8b90" />
`![ASG Failover Log](/images/asg-failover.png)`

**Kết luận:** Hệ thống đã tự động phục hồi thành công (Self-healing) đúng như thiết kế kiến trúc.
