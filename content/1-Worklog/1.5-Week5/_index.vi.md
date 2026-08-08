---
title: "Worklog Tuần 5"
date: 2026-07-20
weight: 5
chapter: false
pre: " <b> 1.5. </b> "
---

### Thời gian

**20/07/2026 - 26/07/2026**

### Công việc đã thực hiện / kế hoạch

* Tạo Launch Template sử dụng Amazon Linux 2023 và user_data chạy Flask demo.
* Tạo Application Load Balancer, Target Group và Listener HTTP cổng 80.
* Thiết lập health check tại path '/' với interval/threshold phù hợp môi trường lab.
* Tạo Auto Scaling Group trải trên 2 private subnet với min = 2, desired = 2, max = 3 và health_check_type = ELB.

### Kết quả

* Có tối thiểu 2 application instances được quản lý bởi ASG.
* ALB có thể phân phối request tới các target healthy.
* ASG có cơ chế duy trì Desired Capacity khi một instance bị mất.
