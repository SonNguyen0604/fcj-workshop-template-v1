---
title: "5.1 Tổng quan kiến trúc"
date: 2026-08-08
weight: 1
---

## Bài toán

Mục tiêu của kiến trúc là tránh để toàn bộ tầng ứng dụng phụ thuộc vào một EC2 duy nhất. Hệ thống sử dụng 2 Availability Zones trong cùng Region `ap-southeast-1`.

![Sơ đồ High Availability 3-Tier](/images/5-Workshop/5.1-Workshop-overview/ha-architecture.png)

## Luồng truy cập

**User -> Internet Gateway -> Application Load Balancer -> EC2 trong Auto Scaling Group**

Tầng dữ liệu sử dụng **RDS PostgreSQL Multi-AZ**. S3 và CloudWatch phục vụ lưu trữ/monitoring ở mức project hiện tại.

## Dịch vụ và lý do lựa chọn

| Dịch vụ | Vai trò | Lý do lựa chọn |
|---|---|---|
| VPC + Subnets | Network isolation | Tách public/app/database tier và trải trên 2 AZ |
| ALB | Entry point + health check | Chỉ route request tới target healthy |
| EC2 | Chạy Flask demo | Dễ quan sát hostname/instance trong lab |
| Auto Scaling Group | Duy trì capacity | Tạo instance thay thế khi actual capacity giảm |
| RDS PostgreSQL Multi-AZ | Database tier | Managed DB với standby đồng bộ ở AZ khác |
| S3 + Versioning | Object storage | Tách object storage khỏi EC2 lifecycle |
| CloudWatch | Monitoring | Theo dõi CPU và trạng thái Alarm |
| Terraform | Infrastructure as Code | Tái tạo, review và clean-up hạ tầng nhất quán |

## Trade-off của môi trường lab

Project sử dụng `single_nat_gateway = true` để giảm chi phí. Điều này có nghĩa NAT Gateway vẫn là một điểm phụ thuộc chung và không phải cấu hình production HA hoàn chỉnh. Trong production, thiết kế cần cân nhắc NAT theo AZ hoặc các phương án khác tùy workload.
