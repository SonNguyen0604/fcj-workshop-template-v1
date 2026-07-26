---
title: "5.3 Thiết lập Network & Database"
date: 2026-07-27T10:00:00+07:00
weight: 3
---

### 1. Khởi tạo Hạ tầng Mạng (VPC)

Để đảm bảo tính sẵn sàng cao (High Availability), hạ tầng mạng được triển khai trên 2 Availability Zones (AZs) khác nhau. Tôi sử dụng **Terraform** để tự động hóa việc khởi tạo cấu trúc mạng bao gồm:
*   **1 Virtual Private Cloud (VPC)**.
*   **2 Public Subnets** dành cho Application Load Balancer (ALB) và NAT Gateway.
*   **2 Private Subnets** dành cho các EC2 instances chạy ứng dụng.
*   **2 Database Subnets** cách ly hoàn toàn với Internet dành cho cơ sở dữ liệu.

*(Chèn ảnh chụp màn hình VPC của bạn trên AWS Console vào đây)*
`![VPC Architecture](/images/vpc-setup.png)`

### 2. Khởi tạo Cơ sở dữ liệu (RDS PostgreSQL Multi-AZ)

Thay vì cài đặt Database trực tiếp lên EC2 (dễ gây điểm chết SPOF), tôi sử dụng dịch vụ **Amazon RDS (PostgreSQL)**. 

Yếu tố cốt lõi để đạt điểm tuyệt đối cho phần này là bật tính năng **Multi-AZ Deployment**. Khi được kích hoạt, AWS sẽ tự động đồng bộ dữ liệu (synchronous replication) sang một bản Standby ở AZ thứ 2. Nếu Database chính gặp sự cố, hệ thống sẽ tự động chuyển hướng (failover) sang bản Standby mà không gây mất dữ liệu.

*(Chèn ảnh chụp màn hình RDS hiển thị trạng thái Multi-AZ = Yes vào đây)*
`![RDS Multi-AZ](/images/rds-multiaz.png)`
