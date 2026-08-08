---
title: "5.1 Tổng quan kiến trúc"
date: 2026-08-08
weight: 1
---

## Kiến trúc tổng thể

![Sơ đồ High Availability 3-Tier](/fcj-workshop-template-v1/images/5-Workshop/5.1-workshop-overview/ha-architecture.png)

Luồng truy cập chính:

**User -> Internet Gateway -> Application Load Balancer -> EC2 trong Auto Scaling Group**

Tầng dữ liệu sử dụng **RDS PostgreSQL Multi-AZ**. S3 cung cấp object storage độc lập với vòng đời EC2; CloudWatch cung cấp monitoring cơ bản.

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

## Phân tách network và security boundary

* **Public subnets:** chứa ALB và NAT Gateway.
* **Private subnets:** chứa EC2 application instances; không nhận inbound trực tiếp từ Internet.
* **Database subnets:** chứa RDS; inbound PostgreSQL chỉ đến từ `app-sg`.
* **Security Group chain:** Internet -> `alb-sg` -> `app-sg` -> `db-sg`.

## High Availability được thể hiện ở đâu?

* Application tier có tối thiểu 2 EC2 trong ASG trải trên 2 private subnets.
* ALB kiểm tra sức khỏe target và chỉ route tới target healthy.
* ASG duy trì Desired Capacity và tạo instance thay thế khi capacity giảm.
* RDS được khai báo `multi_az = true` để AWS quản lý synchronous standby ở AZ khác.

## Trade-off của môi trường lab

`single_nat_gateway = true` giúp giảm chi phí nhưng NAT Gateway vẫn là một điểm phụ thuộc chung. Đây là **trade-off của lab**, không phải cấu hình production HA hoàn chỉnh.
