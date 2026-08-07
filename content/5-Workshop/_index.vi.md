---
title: "Workshop - High Availability trên AWS bằng Terraform"
date: 2026-08-08
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Xây dựng kiến trúc High Availability 3-Tier trên AWS bằng Terraform

Workshop này trình bày lại **project kỹ thuật cá nhân** theo hướng từng bước để người đọc có thể hiểu và tái triển khai một môi trường lab High Availability cơ bản trên AWS.

### Mục tiêu

Sau workshop, người đọc có thể:

* hiểu kiến trúc 3-Tier trên 2 Availability Zones;
* triển khai VPC, Security Groups, RDS Multi-AZ, S3, ALB, Launch Template, ASG và CloudWatch bằng Terraform;
* truy cập Flask demo qua ALB;
* thực hiện kịch bản terminate EC2 và quan sát ASG khôi phục Desired Capacity;
* clean-up tài nguyên để tránh phát sinh chi phí.

### Phạm vi thực tế

Workshop chỉ mô tả những gì đã triển khai hoặc được ghi rõ là giới hạn. Flask hiện chỉ hiển thị RDS endpoint, chưa query database; CloudWatch Alarm chỉ monitoring CPU; chưa test RDS failover/downtime/error rate; chưa có centralized application logging.

### Nội dung

1. [Tổng quan kiến trúc và lựa chọn dịch vụ](5.1-Workshop-overview/)
2. [Prerequisites và chuẩn bị môi trường](5.2-Prerequiste/)
3. [Network, Security, RDS và S3](5.3-Network-Database/)
4. [EC2 Launch Template và Auto Scaling Group](5.4-Compute-Scaling/)
5. [Application Load Balancer và CloudWatch](5.5-Load-Balancing/)
6. [Kiểm thử và Validation](5.6-Failover-Test/)
7. [Clean-up](5.7-Cleanup/)

### Source Terraform

Source dùng trong workshop được đặt tại `static/files/terraform/` của repository. Sau khi push bản cập nhật, có thể xem trực tiếp tại:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>
