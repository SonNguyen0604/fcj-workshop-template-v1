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

Ở lần kiểm tra cuối, `terraform apply` trả về `No changes` vì hạ tầng hiện tại đã khớp với state/configuration. Điều này xác nhận tính đồng nhất của cấu hình, **không phải bằng chứng rằng resource vừa được tạo từ con số 0**.

![Terraform validation](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/terraform-validation.png)

## Test 2 - Inbound traffic qua ALB

Lấy DNS Name từ Terraform output:

```bash
terraform output Link_Truy_Cap_Web
```

Mở DNS trên trình duyệt. Kết quả quan sát:

* Flask demo phản hồi HTTP 200 qua ALB.
* Trang hiển thị hostname của EC2 đang xử lý request.
* Trang hiển thị endpoint RDS được Terraform inject.

![ALB web validation](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/alb-web-validation.png)

> Việc hiển thị endpoint **không đồng nghĩa ứng dụng đã kết nối/query RDS**.

## Test 3 - Terminate một EC2

1. Xác nhận ASG có `Desired Capacity = 2`.
2. Chọn một EC2 thuộc ASG và terminate.
3. Theo dõi Target Group; target lỗi sẽ bị đánh dấu unhealthy sau khi không vượt qua các health check theo interval/threshold.
4. Theo dõi Auto Scaling Activity/EC2; khi actual capacity thấp hơn Desired Capacity, ASG tạo instance thay thế.
5. Chờ instance mới đăng ký vào Target Group và trở thành healthy.

![EC2 replacement](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/ec2-replacement.png)

### Kết quả quan sát

ASG đã tạo instance mới để khôi phục số lượng máy chủ theo cấu hình. Project **chưa đo downtime, error rate hoặc recovery time chính xác**, vì vậy kết quả được đánh giá theo quan sát định tính thay vì cam kết một thời gian phục hồi cố định.

## Test 4 - CloudWatch Alarm

Mở CloudWatch Alarm và xác nhận alarm tồn tại, metric CPU được hiển thị và trạng thái được cập nhật.

![CloudWatch CPU Alarm](/fcj-workshop-template-v1/images/5-Workshop/5.6-Validation/cloudwatch-alarm.png)

Alarm hiện là **monitoring-only**; không có scaling policy theo CPU.

## Bảng tổng hợp validation

| Mục tiêu | Thao tác | Kết quả quan sát | Trạng thái |
|---|---|---|---|
| Terraform config/state nhất quán | `terraform validate/plan/apply` | `No changes`, output ALB DNS | **Pass** |
| User -> ALB -> Flask | Mở ALB DNS | HTTP 200, hiển thị EC2 hostname | **Pass** |
| EC2 self-healing | Terminate 1 EC2 trong ASG | ASG tạo instance mới để khôi phục Desired Capacity | **Pass** |
| Monitoring CPU | Mở CloudWatch Alarm | Alarm và CPU metric hiển thị | **Pass** |
| RDS failover | Chưa chạy failover test | Không có số liệu thực nghiệm | **Not tested** |
| Downtime/error rate | Chưa dùng probe/load test | Không có số liệu định lượng | **Not measured** |
| Dynamic scaling theo tải | Chưa có scaling policy | Alarm chỉ monitoring | **Not implemented** |
| Centralized application logging | Log hiện ở `app.log` local | Log có thể mất khi instance bị thay thế | **Not implemented** |
