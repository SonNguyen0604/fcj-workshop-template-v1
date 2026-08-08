---
title: "Đề xuất Dự án (Proposal)"
date: 2026-06-22
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

## 1. Tổng quan dự án

**Tên dự án:** Đảm bảo tính sẵn sàng cao (High Availability) trên AWS bằng Terraform.

Dự án xây dựng một môi trường 3-Tier dạng lab trên AWS để minh họa cách giảm phụ thuộc vào một máy chủ đơn lẻ. Ứng dụng Python/Flask đóng vai trò workload demo; trọng tâm của project là **thiết kế kiến trúc, triển khai Infrastructure as Code, kiểm thử khả năng tự phục hồi và ghi lại quy trình end-to-end**.

## 2. Bối cảnh và vấn đề cần giải quyết

* Một EC2 đơn lẻ tạo ra Single Point of Failure ở tầng ứng dụng.
* Nếu người dùng truy cập trực tiếp từng EC2, việc thay thế instance sẽ làm thay đổi endpoint và tăng khó khăn vận hành.
* Cơ sở dữ liệu cần cơ chế dự phòng tốt hơn một DB instance đơn lẻ.
* Việc tạo tài nguyên thủ công dễ sai lệch giữa các lần triển khai và khó clean-up.
* Môi trường lab cần kiểm soát chi phí để tránh NAT Gateway/RDS chạy ngoài thời gian cần thiết.

## 3. Đối tượng sử dụng / use-case

Project hướng tới **môi trường học tập, demo kiến trúc và workshop kỹ thuật** cho sinh viên/người mới tiếp cận AWS. Người đọc có thể dùng source Terraform và hướng dẫn để hiểu cách kết hợp nhiều dịch vụ AWS thành một kiến trúc có khả năng phục hồi tốt hơn so với mô hình một máy chủ đơn lẻ.

## 4. Mục tiêu, output và tiêu chí thành công

### Output mong muốn

* Một endpoint ALB có thể truy cập Flask demo qua HTTP.
* Hai EC2 được quản lý bởi Auto Scaling Group và đăng ký vào Target Group.
* RDS PostgreSQL chạy ở chế độ Multi-AZ.
* S3 bucket bật Versioning.
* CloudWatch Alarm theo dõi CPU.
* Source Terraform có thể dùng để deploy/clean-up hạ tầng.
* Website workshop song ngữ có architecture, step-by-step, test/validation, limitation và clean-up.

### Tiêu chí thành công

* VPC trải trên **2 Availability Zones** với public, private và database subnets.
* ALB ở public subnets; EC2 ở private subnets; RDS ở database subnets.
* ASG duy trì `min_size = 2`, `desired_capacity = 2`, `max_size = 3` và dùng `health_check_type = "ELB"`.
* `terraform validate` thành công và `terraform apply` quản lý đúng hạ tầng/state.
* Truy cập ALB trả về HTTP 200 từ Flask demo.
* Khi terminate một EC2, ASG tạo instance thay thế để khôi phục Desired Capacity.
* CloudWatch Alarm tồn tại và hiển thị metric CPU.

## 5. Kiến trúc giải pháp

Các dịch vụ chính:

* **Amazon VPC:** mạng 10.0.0.0/16, 6 subnets trên 2 AZ.
* **Internet Gateway + NAT Gateway:** ALB nhận inbound từ Internet; EC2 private có outbound qua NAT.
* **Application Load Balancer:** entry point public và health check target.
* **Amazon EC2 + Auto Scaling Group:** tầng ứng dụng, min = 2, desired = 2, max = 3.
* **Amazon RDS PostgreSQL Multi-AZ:** tầng dữ liệu có standby đồng bộ do AWS quản lý.
* **Amazon S3:** bucket bật Versioning; bản demo chưa tích hợp upload/download từ Flask.
* **Amazon CloudWatch:** giám sát CPU; application log hiện vẫn ở local `app.log` trên EC2.
* **Terraform:** khai báo, review, tái triển khai và clean-up tài nguyên bằng IaC.

{{< siteimg src="images/ha-architecture.png" alt="Sơ đồ kiến trúc HA" >}}

## 6. Bảo mật và vận hành cơ bản

* Không hard-code AWS Access Key/Secret Key trong source.
* Password RDS được truyền qua Terraform variable `sensitive`; file `terraform.tfvars` và state không được commit.
* Security Group đi theo chuỗi **Internet -> ALB -> App -> DB**, hạn chế EC2/RDS nhận inbound trực tiếp từ Internet.
* EC2 và RDS không public trong kiến trúc lab.
* CloudWatch Alarm phục vụ monitoring; log ứng dụng local và HTTP chưa có TLS được ghi nhận là limitation.

## 7. Timeline 8 tuần

| Tuần | Nội dung chính |
|---|---|
| 1 | Kick-off, chọn đề tài, fork template, AWS Budgets |
| 2 | Networking, HA theory, architecture diagram, Terraform foundation |
| 3 | Flask demo, user_data, Security Groups, sensitive variable |
| 4 | VPC 2 AZ, RDS Multi-AZ, S3 Versioning |
| 5 | ALB, Target Group, Launch Template, ASG |
| 6 | CloudWatch Alarm, rà soát bảo mật và limitation |
| 7 | Terminate EC2, thu thập evidence, hoàn thiện workshop và nộp project 08/08 |
| 8 | Theo dõi phản hồi, duy trì website và kết thúc kỳ thực tập |

## 8. Ngân sách và kiểm soát chi phí

AWS Budgets được cấu hình với ngưỡng cảnh báo nhỏ để phát hiện sớm chi phí phát sinh. Đây là **ngưỡng cảnh báo**, không phải cam kết tổng chi phí luôn dưới mức đó. NAT Gateway và RDS Multi-AZ có thể phát sinh chi phí, vì vậy tài nguyên chỉ được duy trì trong thời gian thực hành và được clean-up khi không còn cần thiết.

Các lựa chọn giảm chi phí cho lab gồm `t3.micro`, một NAT Gateway dùng chung và teardown bằng Terraform. `single_nat_gateway = true` là trade-off về chi phí, không phải cấu hình HA production hoàn chỉnh.

## 9. Rủi ro và biện pháp giảm thiểu

| Rủi ro | Biện pháp |
|---|---|
| Lộ credential/password | Không hard-code access key; dùng CloudShell/CLI profile; không commit `terraform.tfvars`/state |
| EC2/RDS bị truy cập trực tiếp | EC2/RDS private; Security Group theo chuỗi ALB -> App -> DB |
| Single NAT Gateway là SPOF | Chấp nhận trong lab để giảm chi phí; production cần thiết kế NAT theo AZ hoặc giải pháp phù hợp hơn |
| Log mất khi EC2 bị terminate | Ghi nhận limitation; hướng phát triển là CloudWatch Agent/centralized logging |
| Chưa có dynamic scaling | Alarm hiện chỉ monitoring; Target Tracking là hướng mở rộng |
| Chi phí tăng | AWS Budgets + clean-up bằng `terraform destroy` |

## 10. Phạm vi không thực hiện trong phiên bản hiện tại

* Không xây hệ thống Workforce nghiệp vụ đầy đủ.
* Flask demo chưa kết nối/query RDS thực tế.
* Chưa thực nghiệm RDS failover và chưa đo downtime/error rate.
* Chưa tích hợp S3 từ code ứng dụng.
* Chưa cấu hình centralized logging, HTTPS/ACM hoặc dynamic scaling policy.
