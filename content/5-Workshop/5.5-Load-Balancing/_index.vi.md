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

Health check của Target Group dùng **path `/`** với HTTP port 80.

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

ALB là public entry point; EC2 không cần public IP để người dùng truy cập trực tiếp.

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

Application log hiện được ghi tại `/home/ec2-user/app.log`; chưa có CloudWatch Agent/centralized logging.
