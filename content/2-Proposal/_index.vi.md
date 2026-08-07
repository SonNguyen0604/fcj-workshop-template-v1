---
title: "Đề xuất Dự án (Proposal)"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

## 1. Tổng quan dự án

**Tên dự án:** Đảm bảo tính sẵn sàng cao (High Availability) trên AWS bằng Terraform.

Dự án xây dựng một môi trường 3-Tier dạng lab trên AWS để minh họa cách giảm phụ thuộc vào một máy chủ đơn lẻ. Ứng dụng Python/Flask đóng vai trò workload demo; trọng tâm của project là thiết kế, triển khai, vận hành và kiểm thử hạ tầng cloud.

## 2. Bối cảnh và vấn đề cần giải quyết

* Một EC2 đơn lẻ tạo ra Single Point of Failure ở tầng ứng dụng.
* Nếu không có Load Balancer, người dùng phải phụ thuộc vào địa chỉ của từng máy chủ.
* Cơ sở dữ liệu cần có cơ chế dự phòng tốt hơn một DB instance đơn lẻ.
* Việc tạo tài nguyên thủ công dễ sai lệch giữa các lần triển khai và khó clean-up.
* Môi trường lab cần kiểm soát chi phí để tránh NAT Gateway/RDS chạy ngoài thời gian cần thiết.

## 3. Mục tiêu và tiêu chí thành công

* Tạo VPC trên **2 Availability Zones** với public, private và database subnets.
* Đặt **Application Load Balancer** ở public subnets và EC2 ở private subnets.
* Duy trì **2 EC2** trong Auto Scaling Group với `health_check_type = "ELB"`.
* Triển khai **RDS PostgreSQL Multi-AZ** và S3 Versioning.
* Dùng **Terraform** để khai báo và quản lý hạ tầng.
* Cấu hình **CloudWatch CPU Alarm** để giám sát.
* Kiểm thử bằng cách terminate một EC2 và quan sát ASG tạo instance thay thế.
* Kết quả được xem là đạt khi ALB vẫn có target phục vụ và ASG khôi phục Desired Capacity sau sự cố EC2.

## 4. Kiến trúc giải pháp

Các dịch vụ chính:

* **Amazon VPC:** mạng 10.0.0.0/16, 6 subnets trên 2 AZ.
* **Internet Gateway + NAT Gateway:** ALB nhận inbound từ Internet; EC2 private có outbound qua NAT.
* **Application Load Balancer:** điểm truy cập của người dùng và health check target.
* **Amazon EC2 + Auto Scaling Group:** tầng ứng dụng, min = 2, desired = 2, max = 3.
* **Amazon RDS PostgreSQL Multi-AZ:** tầng dữ liệu có standby đồng bộ do AWS quản lý.
* **Amazon S3:** bucket có Versioning; trong bản demo hiện chưa tích hợp upload/download từ Flask.
* **Amazon CloudWatch:** giám sát CPU; application log vẫn ở local `app.log` trên EC2.

![Sơ đồ kiến trúc HA](/images/5-Workshop/5.1-Workshop-overview/ha-architecture.png)

## 5. Timeline 8 tuần

| Tuần | Nội dung chính |
|---|---|
| 1 | Kick-off, chọn đề tài, fork template, AWS Budgets |
| 2 | Networking, HA theory, architecture diagram, Terraform foundation |
| 3 | Flask demo, user_data, Security Groups, sensitive variable |
| 4 | VPC 2 AZ, RDS Multi-AZ, S3 Versioning |
| 5 | ALB, Target Group, Launch Template, ASG |
| 6 | CloudWatch Alarm, rà soát bảo mật và limitation |
| 7 | Terminate EC2, quan sát self-healing, thu thập evidence |
| 8 | Hoàn thiện workshop, blogs, events, report và clean-up |

## 6. Ngân sách và kiểm soát chi phí

AWS Budgets được cấu hình với ngưỡng cảnh báo nhỏ để phát hiện sớm chi phí phát sinh. Đây là **ngưỡng cảnh báo**, không phải cam kết tổng chi phí luôn dưới mức đó. NAT Gateway và RDS Multi-AZ có thể phát sinh chi phí, vì vậy tài nguyên chỉ được duy trì trong thời gian thực hành và được clean-up khi không còn cần thiết.

## 7. Rủi ro và biện pháp giảm thiểu

| Rủi ro | Biện pháp |
|---|---|
| Lộ credential/password | Không hard-code access key; dùng AWS CloudShell/CLI profile và Terraform sensitive variable |
| EC2/RDS bị truy cập trực tiếp | EC2/RDS không public; SG theo chuỗi ALB -> App -> DB |
| Single NAT Gateway là SPOF | Chấp nhận trong lab để giảm chi phí; production nên có NAT theo AZ hoặc kiến trúc phù hợp hơn |
| Log mất khi EC2 bị terminate | Ghi nhận limitation; hướng phát triển là CloudWatch Agent/centralized logging |
| Chưa có dynamic scaling | CloudWatch Alarm hiện chỉ monitoring; Target Tracking là hướng mở rộng |
| Chi phí tăng | AWS Budgets + `terraform destroy` sau khi kiểm thử |

## 8. Phạm vi không thực hiện trong phiên bản hiện tại

* Không xây hệ thống Workforce nghiệp vụ đầy đủ.
* Flask demo chưa kết nối/query RDS thực tế.
* Chưa thực nghiệm RDS failover, chưa đo downtime/error rate.
* Chưa tích hợp S3 từ code ứng dụng.
* Chưa cấu hình centralized logging hoặc dynamic scaling policy.
