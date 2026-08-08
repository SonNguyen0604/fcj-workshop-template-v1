# 1. AWS Provider and database password variable
provider "aws" {
  region = "ap-southeast-1"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for the PostgreSQL RDS database"
}

# 2. VPC and six subnets across two Availability Zones
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name    = "workforce-ha-vpc-v2"
  cidr    = "10.0.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]

  create_database_subnet_group = true
  enable_nat_gateway           = true
  single_nat_gateway           = true
}

# 3. Security Groups for ALB, application instances and RDS
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name   = "app-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. PostgreSQL RDS Multi-AZ
resource "aws_db_instance" "ha_db" {
  identifier             = "workforce-ha-db-v2"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "workforcedb"
  username               = "dbadmin"
  password               = var.db_password
  multi_az               = true
  # Lab-only: skip final snapshot to simplify teardown
  skip_final_snapshot    = true
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

# 5. S3 bucket with Versioning
resource "aws_s3_bucket" "app_storage" {
  bucket        = "workforce-ha-storage-sn-2026"
  # Lab-only: allow bucket cleanup during terraform destroy
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "app_storage_versioning" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 6. Application Load Balancer, Target Group and Listener
resource "aws_lb" "app_alb" {
  name               = "workforce-alb-v2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets
}

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

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# 7. Latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 8. Launch Template and Flask demo bootstrap
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

# 9. Auto Scaling Group maintaining two application instances
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

# 10. CloudWatch CPU monitoring alarm (no scaling action attached)
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

# Output the public ALB DNS name
output "Link_Truy_Cap_Web" {
  value = aws_lb.app_alb.dns_name
}
