---
title: "Blog 1 - Quản lý chi phí chủ động với AWS Budgets"
date: 2026-06-24
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---

# Từ nỗi lo hóa đơn đến thói quen FinOps: kiểm soát lab bằng AWS Budgets

Khi mới thực hành AWS, rủi ro dễ gặp không chỉ là cấu hình sai mà còn là **quên tài nguyên đang chạy**. Một NAT Gateway, RDS instance hoặc EC2 để lâu hơn dự kiến có thể tạo chi phí dù mình không còn sử dụng.

Trong tuần đầu của kỳ thực tập, tôi chọn AWS Budgets làm lớp cảnh báo tài chính cho tài khoản lab trước khi triển khai kiến trúc High Availability.

## Bài toán

Project HA sử dụng nhiều loại tài nguyên: VPC, NAT Gateway, EC2, Application Load Balancer, RDS Multi-AZ, S3 và CloudWatch. Mỗi dịch vụ có cách tính phí khác nhau, vì vậy việc chỉ thỉnh thoảng mở Billing Console để kiểm tra là cách làm bị động.

## Cách tôi cấu hình

1. Tạo **Monthly Cost Budget**.
2. Đặt một mức ngân sách nhỏ phù hợp môi trường học tập.
3. Cấu hình cảnh báo sớm trước khi đạt toàn bộ ngân sách.
4. Đăng ký email nhận thông báo.
5. Khi có cảnh báo, kiểm tra Cost Explorer/Billing và dọn các resource không cần thiết.

Trong môi trường lab, tôi ưu tiên đặt ngưỡng ngân sách nhỏ và cảnh báo sớm để phát hiện chi phí bất thường. Đây là **ngưỡng cảnh báo**, không có nghĩa AWS sẽ tự động dừng toàn bộ dịch vụ khi đạt mức đó.

## Điều tôi học được

* Cost control nên được thiết lập **trước** khi tạo nhiều resource.
* NAT Gateway và RDS Multi-AZ là các thành phần cần chú ý khi làm lab trong thời gian dài.
* `terraform destroy` là bước vận hành quan trọng, không chỉ là thao tác cuối cùng cho đẹp.
* FinOps cơ bản giúp mình tự tin thử nghiệm hơn vì biết có cơ chế cảnh báo sớm.

## Gợi ý cho người mới

AWS Budgets không thay thế việc đọc Pricing hay kiểm tra Billing. Nó hoạt động tốt nhất khi kết hợp với thói quen tag resource, clean-up sau lab và chỉ duy trì tài nguyên trong thời gian thật sự cần.

**Liên hệ project:** Tôi sử dụng AWS Budgets để kiểm soát chi phí trong quá trình dựng kiến trúc HA bằng Terraform.

**Link bài đăng trên AWS Study Group:** _Cần cập nhật sau khi đăng/đối chiếu URL bài đã đăng._
