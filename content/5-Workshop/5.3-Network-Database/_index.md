---
title: "5.3 Network, Security, RDS and S3"
date: 2026-08-08
weight: 3
---

## Step 1 - Create the VPC and six subnets across two AZs

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

**Verify:** the VPC contains two public, two private and two database subnets. `single_nat_gateway = true` is a cost-saving lab trade-off.

<img width="1892" height="912" alt="VPC" src="https://github.com/user-attachments/assets/2505d986-eea9-41b4-b7b9-3c816a384eed" />

## Step 2 - Security Groups: ALB -> App -> DB

* `alb-sg`: TCP/80 inbound from `0.0.0.0/0`.
* `app-sg`: TCP/80 inbound only from `alb-sg`.
* `db-sg`: TCP/5432 inbound only from `app-sg`.

**Verify:** EC2 and RDS do not require public inbound rules; application traffic enters through the ALB.

## Step 3 - Create PostgreSQL RDS Multi-AZ

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

`skip_final_snapshot = true` is only for fast teardown in the lab. Production needs an appropriate backup/snapshot/deletion-protection policy.

<img width="1906" height="858" alt="RDS Multi-AZ" src="https://github.com/user-attachments/assets/cacd926c-1b5f-4c9f-851d-97b438feeda1" />

**Verify:** RDS shows Multi-AZ and uses the VPC database subnet group.

## Step 4 - S3 and Versioning

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

`force_destroy = true` is only for convenient lab clean-up. The Flask demo does not upload/download S3 objects; the bucket demonstrates storage independent from EC2 lifecycle.

**Verify:** S3 Console shows Versioning = Enabled.
