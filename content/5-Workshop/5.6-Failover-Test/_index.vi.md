---
title: "5.6 Kiểm thử và Validation"
date: 2026-08-08
weight: 6
---

## Test 1 - Terraform validation

Chạy:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

Ở lần kiểm tra cuối, `terraform apply` có thể trả về `No changes` nếu hạ tầng hiện tại đã khớp với state/configuration. Điều này xác nhận tính đồng nhất, không phải bằng chứng rằng tài nguyên vừa được tạo từ con số 0.

## Test 2 - Inbound traffic qua ALB

Lấy DNS Name từ Terraform output:

```hcl
output "Link_Truy_Cap_Web" {
  value = aws_lb.app_alb.dns_name
}
```

Mở DNS trên trình duyệt. Kết quả mong đợi:

* HTTP 200 từ Flask demo.
* Trang hiển thị hostname của EC2 đang xử lý request.
* Trang hiển thị cấu hình endpoint RDS được Terraform inject.

Việc hiển thị endpoint **không đồng nghĩa ứng dụng đã query RDS**.

## Test 3 - Terminate một EC2

1. Đảm bảo ASG có `Desired Capacity = 2`.
2. Chọn một EC2 đang thuộc ASG và terminate.
3. Quan sát Target Group. Sau khi target không vượt qua các health check theo interval/threshold, target bị đánh dấu unhealthy.
4. Quan sát Auto Scaling Activity/EC2. Khi actual capacity thấp hơn Desired Capacity, ASG tạo instance thay thế.
5. Chờ instance mới đăng ký vào Target Group và trở thành healthy.

<img width="1888" height="922" alt="EC2 replacement" src="https://github.com/user-attachments/assets/3a2eab26-9fa7-4726-a82a-3e06555a220a" />
<img width="1893" height="893" alt="CloudWatch/ASG evidence" src="https://github.com/user-attachments/assets/1f0c3569-549f-491a-b91e-0502c3456fd0" />

### Kết quả quan sát

ASG đã tạo instance mới để khôi phục số lượng máy chủ theo cấu hình. Project **chưa đo downtime, error rate hoặc recovery time chính xác**, vì vậy workshop không tuyên bố Zero Downtime hay thời gian phục hồi cố định.

## Test 4 - CloudWatch

Mở CloudWatch Alarm và xác nhận alarm tồn tại, metric CPU được hiển thị và trạng thái được cập nhật. Alarm hiện là monitoring-only.

## Bảng tổng hợp

| Test | Kết quả |
|---|---|
| Terraform state/config validation | Pass |
| ALB -> Flask demo | Pass |
| EC2 terminate -> ASG replacement | Pass |
| CloudWatch CPU monitoring | Pass |
| RDS failover | Chưa thực hiện |
| Downtime/error-rate measurement | Chưa thực hiện |
| Dynamic scaling theo CPU | Chưa triển khai |
| Centralized application logging | Chưa triển khai |
