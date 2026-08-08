---
title: "Workshop - High Availability trên AWS bằng Terraform"
date: 2026-08-08
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Xây dựng kiến trúc High Availability 3-Tier trên AWS bằng Terraform

Đây là **project kỹ thuật cá nhân** của tôi, được viết lại theo dạng workshop end-to-end để người đọc có thể hiểu kiến trúc, xem source, triển khai lab, kiểm thử và clean-up.

## Mục tiêu workshop

Sau workshop, người đọc có thể:

* hiểu kiến trúc 3-Tier trải trên 2 Availability Zones;
* triển khai VPC, Security Groups, RDS Multi-AZ, S3, ALB, Launch Template, Auto Scaling Group và CloudWatch bằng Terraform;
* truy cập Flask demo thông qua ALB;
* terminate một EC2 và quan sát ASG khôi phục Desired Capacity;
* phân biệt self-healing với dynamic scaling;
* nhận biết các trade-off về chi phí, bảo mật và vận hành của môi trường lab;
* clean-up resource để tránh phát sinh chi phí.

## Phạm vi thực tế

Workshop chỉ mô tả những gì đã triển khai hoặc ghi rõ là giới hạn. Flask hiện **chỉ hiển thị endpoint RDS**, chưa kết nối/query database; CloudWatch Alarm chỉ monitoring CPU; chưa test RDS failover, chưa đo downtime/error rate và chưa có centralized application logging.

## Nội dung

1. [Tổng quan kiến trúc và lựa chọn dịch vụ](5.1-workshop-overview/)
2. [Prerequisites và chuẩn bị môi trường](5.2-prerequisites/)
3. [Network, Security, RDS và S3](5.3-network-database/)
4. [EC2 Launch Template và Auto Scaling Group](5.4-compute-scaling/)
5. [Application Load Balancer và CloudWatch](5.5-load-balancing/)
6. [Kiểm thử và Validation](5.6-failover-test/)
7. [Tối ưu, bảo mật và giới hạn](5.7-optimization-limitations/)
8. [Clean-up](5.8-cleanup/)

## Source Terraform đính kèm

* [main.tf](/files/terraform/main.tf)
* [terraform.tfvars.example](/files/terraform/terraform.tfvars.example)
* [README hướng dẫn chạy](/files/terraform/README.md)

Source cũng được lưu tại repository:

<https://github.com/SonNguyen0604/fcj-workshop-template-v1/tree/main/static/files/terraform>
