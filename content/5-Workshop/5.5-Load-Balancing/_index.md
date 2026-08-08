---
title: "5.5 Application Load Balancer and CloudWatch"
date: 2026-08-08
weight: 5
---

## Step 1 - Target Group and Health Check

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

The health check uses **path `/`** on HTTP port 80. With `unhealthy_threshold = 2`, a target becomes unhealthy only after failing the configured health checks, so the state change is not instantaneous.

## Step 2 - Create the ALB and Listener

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

The ALB is the public entry point; users do not access EC2 instances directly.

<img width="1895" height="908" alt="ALB" src="https://github.com/user-attachments/assets/a4e0d2c0-3298-4e74-9bdd-878b3fa232c4" />
<img width="1900" height="903" alt="Target Group" src="https://github.com/user-attachments/assets/0f53e104-5ec8-47b7-8a19-b1a5581b31a3" />

## Step 3 - CloudWatch CPU Alarm

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

This alarm is **monitoring-only**. The current project has no `aws_autoscaling_policy`, so the CloudWatch Alarm is not described as a CPU-driven scaling mechanism.

## Verify

* The ALB DNS returns HTTP 200 from the Flask demo.
* The Target Group shows healthy targets.
* The CloudWatch Alarm exists and displays the CPU metric.
* The lab currently uses HTTP without TLS/ACM; HTTPS is a production improvement.
