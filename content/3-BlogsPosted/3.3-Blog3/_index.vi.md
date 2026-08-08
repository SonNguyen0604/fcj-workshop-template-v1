---
title: "Blog 3 - RDS Multi-AZ và CloudWatch: dữ liệu bền vững hơn, hệ thống dễ quan sát hơn"
date: 2026-08-08
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---

# RDS Multi-AZ + CloudWatch: hai mảnh ghép quan trọng của kiến trúc HA

High Availability không chỉ là có nhiều EC2. Nếu tầng dữ liệu vẫn phụ thuộc vào một database đơn lẻ hoặc hệ thống không có monitoring, người vận hành vẫn gặp khó khăn khi sự cố xảy ra.

Trong project của tôi, hai dịch vụ được dùng cho hai mục tiêu khác nhau: **Amazon RDS PostgreSQL Multi-AZ** cho độ bền bỉ của database và **Amazon CloudWatch** cho giám sát tài nguyên.

## RDS Multi-AZ giải quyết vấn đề gì?

Với cấu hình `multi_az = true`, RDS duy trì một standby đồng bộ ở Availability Zone khác. AWS quản lý cơ chế failover và endpoint DB cho người dùng.

Điều cần lưu ý:

* Multi-AZ tập trung vào **high availability**, không phải read scaling.
* Ứng dụng nên sử dụng RDS endpoint thay vì hard-code IP database.
* Failover có thể tạo gián đoạn tạm thời; không nên mô tả là zero downtime tuyệt đối.

Trong bản demo hiện tại, tôi đã triển khai RDS Multi-AZ nhưng **chưa chạy kịch bản RDS failover thực tế** và Flask cũng chưa query DB. Tôi ghi rõ giới hạn này thay vì suy diễn kết quả.

## CloudWatch trong project

Tôi cấu hình CloudWatch Metric Alarm để theo dõi `CPUUtilization` của nhóm EC2. Alarm hiện tại phục vụ monitoring; nó **chưa được nối với scaling policy** để tự scale theo CPU.

Application log được ghi vào `app.log` trên từng EC2. Đây là một limitation vì log local sẽ mất theo vòng đời instance. Hướng phát triển hợp lý là cài CloudWatch Agent hoặc một cơ chế centralized logging.

## Bài học vận hành

* HA cần quan sát được: không có metric/log thì rất khó biết hệ thống đang phục hồi thế nào.
* Monitoring và Auto Scaling là hai khái niệm liên quan nhưng không đồng nghĩa.
* Managed service như RDS Multi-AZ giảm phần việc vận hành, nhưng vẫn cần kiểm thử và hiểu hành vi failover.
* Báo cáo kỹ thuật tốt nên nói rõ phần **đã test** và phần **chỉ mới cấu hình**.

---

## Thông tin chia sẻ

* **Ngày tạo nội dung:** 08/08/2026
* **Ngày đăng:** 08/08/2026
* **Nơi đăng:** AWS Study Group VN
* **Trạng thái:** Đã đăng và được quản trị viên phê duyệt.

## Minh chứng

{{< assetimg src="images/3-BlogsPosted/blog3-aws-study-group.png" alt="Minh chứng bài viết đã đăng trên AWS Study Group VN" >}}
