# Day 01 – Foundations & Remote State

## Objectives
- Understand Well-Architected pillars and baseline org structure
- Initialize Terraform backend (S3 + DynamoDB lock) with encryption
- Create IAM bootstrap (terraform execution role, read-only role)
- Record ADR-0001 (Remote State Decision)

## Tasks Checklist
- [ ] Draft ADR-0001
- [ ] Create S3 state bucket (private, versioning, SSE-KMS)
- [ ] Create DynamoDB lock table
- [ ] Terraform backend config committed
- [ ] IAM role: terraform-exec with least privilege
- [ ] Tag strategy draft (Owner, CostCenter, Env)
- [ ] Document security considerations

## Copilot Prompts
```
Generate Terraform backend snippet referencing remote state S3 bucket + DynamoDB lock; expose bucket, table, kms_key_id as variables.
```
```
Draft IAM policy JSON for Terraform to manage VPC, IAM (read), EC2, S3 state bucket; deny deletion of state bucket.
```

## Validation
Commands (after creation):
- `terraform init` (no errors)
- `aws s3api get-bucket-encryption`
- IAM policy simulator: confirm deny on bucket delete.

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add tflint & checkov later
- Consider state locking alarm (CloudWatch Event on DynamoDB errors)
