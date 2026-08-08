---
title: "5.7 Tối ưu, bảo mật và giới hạn"
date: 2026-08-08
weight: 7
---

## Tối ưu chi phí cho môi trường lab

* Sử dụng `t3.micro` cho EC2 và `db.t3.micro` cho RDS để phù hợp quy mô demo.
* Dùng `single_nat_gateway = true` để giảm chi phí NAT; đây là trade-off và tạo một điểm phụ thuộc chung.
* Dùng AWS Budgets để cảnh báo sớm chi phí phát sinh.
* Chỉ duy trì NAT Gateway/RDS Multi-AZ trong thời gian cần kiểm thử và clean-up bằng Terraform sau khi kết thúc lab.

## Bảo mật cơ bản

* Không hard-code AWS Access Key/Secret Key trong source.
* Password RDS được truyền qua `sensitive` variable; real `terraform.tfvars` và Terraform state không commit lên GitHub.
* `alb-sg` là lớp public inbound; `app-sg` chỉ nhận từ ALB; `db-sg` chỉ nhận PostgreSQL từ application tier.
* EC2 và RDS không được thiết kế để người dùng Internet truy cập trực tiếp.

## Giới hạn của phiên bản hiện tại

| Giới hạn | Ảnh hưởng | Hướng cải thiện |
|---|---|---|
| Một NAT Gateway | Chưa loại bỏ hoàn toàn network SPOF | NAT theo AZ hoặc thiết kế giảm phụ thuộc NAT |
| HTTP port 80 | Chưa mã hóa traffic từ client đến ALB | ACM + HTTPS listener/redirect HTTP -> HTTPS |
| Flask chỉ hiển thị RDS endpoint | Chưa chứng minh DB query/retry | Kết nối PostgreSQL thật + connection pool/retry |
| S3 chưa tích hợp application | Chưa có workflow object thực tế | IAM role least privilege + upload/download/presigned URL |
| Log ở local `app.log` | Có thể mất khi EC2 bị terminate | CloudWatch Agent/CloudWatch Logs |
| Chưa test RDS failover | Chưa có recovery evidence ở DB tier | Reboot with failover + probe + data validation |
| Chưa đo downtime/error rate | Chưa có KPI định lượng | Script probe/k6/Locust và ghi p95/error rate |
| Chưa có dynamic scaling | ASG chỉ self-healing/maintain capacity | Target Tracking theo CPU hoặc ALB request metric |

## Điểm quan trọng

Project này tập trung vào **HA cơ bản và self-healing ở application tier**. Việc ghi rõ limitation là một phần của đánh giá kỹ thuật, tránh biến các mục chưa triển khai thành tuyên bố đã hoàn thành.
