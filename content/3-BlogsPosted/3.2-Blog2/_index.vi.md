---
title: "Blog 2 - ALB và Auto Scaling Group: tầng ứng dụng tự phục hồi"
date: 2026-08-08
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---

# ALB + Auto Scaling Group: cách tôi xây tầng ứng dụng tự phục hồi trên AWS

Một ứng dụng chạy trên đúng một EC2 instance có một vấn đề rất rõ: nếu máy đó lỗi, người dùng mất điểm truy cập. Trong project High Availability, tôi kết hợp **Application Load Balancer (ALB)** và **Auto Scaling Group (ASG)** để giảm phụ thuộc vào một máy chủ duy nhất.

## Vai trò của ALB

ALB là điểm truy cập public của ứng dụng. Thay vì người dùng gọi thẳng vào EC2, request đi qua ALB và được chuyển đến các target đang healthy.

Trong lab của tôi:

* ALB nằm ở public subnets.
* EC2 nằm ở private subnets.
* Target Group dùng HTTP port 80.
* Health check dùng path `/`.

Điểm quan trọng là ALB **không sửa máy hỏng**. Nó chỉ ngừng route traffic tới target không còn healthy.

## Vai trò của Auto Scaling Group

ASG quản lý số lượng EC2 theo cấu hình:

* `min_size = 2`
* `desired_capacity = 2`
* `max_size = 3`
* `health_check_type = "ELB"`

Khi một instance bị terminate, actual capacity giảm xuống dưới Desired Capacity. ASG sau đó tạo instance mới từ Launch Template để khôi phục số lượng máy chủ mong muốn.

## ALB và ASG bổ sung cho nhau như thế nào?

* **ALB** giải quyết bài toán routing và health check.
* **ASG** giải quyết bài toán duy trì capacity và thay thế instance.
* **Launch Template** giúp instance mới có cùng AMI, Security Group và user_data.

Kết quả là tầng ứng dụng có khả năng **self-healing** tốt hơn so với mô hình một EC2 đơn lẻ.

## Một điểm dễ nhầm: self-healing không đồng nghĩa dynamic scaling

Trong bản demo hiện tại, CloudWatch Alarm của tôi chỉ dùng để monitoring CPU. Tôi **chưa cấu hình Target Tracking/Dynamic Scaling policy theo tải**. Vì vậy project chứng minh ASG duy trì Desired Capacity khi instance lỗi, không tuyên bố đã tự scale-out theo CPU.

Nếu mở rộng project, có thể bổ sung Target Tracking với metric như `ASGAverageCPUUtilization` hoặc `ALBRequestCountPerTarget` tùy workload.

## Bài học rút ra

High Availability không đến từ một service duy nhất. ALB, Target Group, Launch Template và ASG phải được cấu hình nhất quán. Quan trọng hơn, khi viết báo cáo cần phân biệt rõ **traffic routing**, **instance replacement** và **dynamic scaling** vì đây là ba cơ chế khác nhau.

---

## Thông tin chia sẻ

* **Ngày tạo nội dung:** 08/08/2026
* **Ngày đăng:** 08/08/2026
* **Nơi đăng:** AWS Study Group VN
* **Trạng thái:** Đã đăng và được quản trị viên phê duyệt.

## Minh chứng

{{< siteimg src="images/3-BlogsPosted/blog2-aws-study-group.png" alt="Minh chứng bài viết đã đăng trên AWS Study Group VN" >}}
