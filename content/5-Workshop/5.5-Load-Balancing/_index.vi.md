---
title: "5.5 Application Load Balancer và CloudWatch"
date: 2026-08-08
weight: 5
---

## Bước 1 - Target Group và Health Check

```hcl
resource "aws_lb_target_group" "app_tg" {
  name     = "workforce-tg-v2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
```

Health check dùng **path `/`** trên HTTP port 80. Với `unhealthy_threshold = 2`, target chỉ bị đánh dấu unhealthy sau khi không vượt qua số lần health check theo cấu hình, vì vậy trạng thái không chuyển sang unhealthy tức thời.

## Bước 2 - Tạo ALB và Listener

```hcl
resource "aws_lb" "app_alb" {
  name               = "workforce-alb-v2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
```

ALB là public entry point; người dùng không truy cập EC2 trực tiếp.

<img width="1895" height="908" alt="ALB" src="https://github.com/user-attachments/assets/5a3f549e-81e5-4f54-9a92-aaab04e2d60a" />
<img width="1900" height="903" alt="Target Group" src="https://github.com/user-attachments/assets/9d9627a9-24c7-4f89-9f25-7997452a32db" />

## Bước 3 - CloudWatch CPU Alarm

```hcl
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "workforce-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Giam sat CPU EC2"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }
}
```

Alarm này **chỉ dùng để giám sát**. Project hiện chưa có `aws_autoscaling_policy`, nên không mô tả CloudWatch Alarm là cơ chế tự scale theo CPU.

## Kiểm tra

* ALB DNS trả về HTTP 200 từ Flask demo.
* Target Group hiển thị target healthy.
* CloudWatch Alarm tồn tại và hiển thị CPU metric.
* HTTP hiện chưa có TLS/ACM; HTTPS là hướng phát triển cho production.
