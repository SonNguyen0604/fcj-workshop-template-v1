# Terraform source for the FCAJ High Availability workshop

## Files

- `main.tf`: AWS infrastructure used by the workshop.
- `terraform.tfvars.example`: example variable file without real secrets.

## Run

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the placeholder with a strong lab password.
3. Do **not** commit the real `terraform.tfvars`, Terraform state, AWS credentials or plan files.
4. Run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Get the web endpoint:

```bash
terraform output Link_Truy_Cap_Web
```

Clean up after evidence/testing is complete:

```bash
terraform plan -destroy
terraform destroy --auto-approve
```

## Lab notes

- `sensitive = true` hides the password from some Terraform output, but does **not** encrypt it in state.
- `single_nat_gateway = true` is a cost-saving trade-off and not a fully redundant production NAT design.
- `skip_final_snapshot = true` and S3 `force_destroy = true` are intended for disposable lab resources.
- The Flask demo displays the RDS endpoint but does not connect to/query the database.
- The CloudWatch CPU alarm is monitoring-only; no dynamic scaling policy is included.
- Application logs remain local in `/home/ec2-user/app.log`.
