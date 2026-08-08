---
title: "5.4 EC2 Launch Template and Auto Scaling Group"
date: 2026-08-08
weight: 4
---

## Step 1 - Select the latest Amazon Linux 2023 AMI

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
```

## Step 2 - Launch Template and Flask demo

The Launch Template uses `t3.micro`, `app-sg` and `user_data`. Flask is installed and started directly during instance boot.

```hcl
resource "aws_launch_template" "app_lt" {
  name                   = "workforce-app-lt"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3 python3-pip
    pip3 install Flask
    cat << 'PYTHON' > /home/ec2-user/app.py
    import socket
    from flask import Flask
    app = Flask(__name__)

    @app.route('/')
    def hello():
        hostname = socket.gethostname()
        db_endpoint = "${aws_db_instance.ha_db.endpoint}"
        return f"<h1>He thong HA 3-Tier hoat dong tot!</h1><p><b>EC2 Node:</b> {hostname}</p><p><b>Database:</b> {db_endpoint}</p>"

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=80)
    PYTHON
    nohup python3 /home/ec2-user/app.py > /home/ec2-user/app.log 2>&1 &
  EOF
  )
}
```

The Flask app **only displays the RDS endpoint injected by Terraform**; it does not open a PostgreSQL connection or query the database. `app.log` remains local on EC2.

## Step 3 - Auto Scaling Group

```hcl
resource "aws_autoscaling_group" "app_asg" {
  vpc_zone_identifier = module.vpc.private_subnets
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
}
```

The configuration focuses on **Desired Capacity maintenance and self-healing**. `max_size = 3` leaves room for future scaling, but the current project has no CPU-based dynamic scaling policy.

## Verify

* ASG shows `Min = 2`, `Desired = 2`, `Max = 3`.
* Two EC2 instances are Running and managed by the ASG.
* Instances do not expose Public IPv4 DNS in the private-subnet design.
* The Target Group receives instances registered through the ASG.
