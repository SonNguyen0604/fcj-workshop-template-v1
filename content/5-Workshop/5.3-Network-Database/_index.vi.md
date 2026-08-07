---
title: "5.3 Network, Security, RDS và S3"
date: 2026-08-08
weight: 3
---

## Bước 1 - Tạo VPC và 6 subnets trên 2 AZ

```hcl
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
```

Kết quả mong đợi: VPC có 2 public, 2 private và 2 database subnets. Single NAT chỉ là trade-off cho lab.

<img width="1892" height="912" alt="VPC" src="https://github.com/user-attachments/assets/6d00ac3d-921d-4c7b-85b1-2f851e93d0b7" />

## Bước 2 - Security Groups theo chuỗi ALB -> App -> DB

* `alb-sg`: inbound TCP/80 từ Internet.
* `app-sg`: inbound TCP/80 chỉ từ `alb-sg`.
* `db-sg`: inbound TCP/5432 chỉ từ `app-sg`.

Cách này giảm việc expose trực tiếp EC2/RDS ra Internet.

## Bước 3 - Tạo RDS PostgreSQL Multi-AZ

```hcl
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
  skip_final_snapshot    = true
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
```

`skip_final_snapshot = true` chỉ phù hợp cho môi trường lab cần teardown nhanh. Với production cần chính sách backup/snapshot/deletion protection phù hợp.

<img width="1906" height="858" alt="RDS Multi-AZ" src="https://github.com/user-attachments/assets/a1520d34-f18e-477d-a8ed-d84177ad84e8" />

## Bước 4 - S3 và Versioning

```hcl
resource "aws_s3_bucket" "app_storage" {
  bucket        = "workforce-ha-storage-sn-2026"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "app_storage_versioning" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}
```

`force_destroy = true` được dùng để thuận tiện clean-up lab. Flask hiện chưa upload/download object từ S3; bucket được triển khai để thể hiện storage độc lập với vòng đời EC2.
