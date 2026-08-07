# Terraform source for the FCAJ High Availability workshop

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the placeholder with a strong lab password.
3. Do **not** commit the real `terraform.tfvars` file.
4. Run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Clean up after testing:

```bash
terraform destroy --auto-approve
```

Lab notes:

- `single_nat_gateway = true` is a cost-saving trade-off and not a fully redundant production NAT design.
- `skip_final_snapshot = true` and S3 `force_destroy = true` are intended for disposable lab resources.
- The Flask demo displays the RDS endpoint but does not connect to/query the database.
- The CloudWatch CPU alarm is monitoring-only; no dynamic scaling policy is included.
