# Day 04 – Storage

## Objectives
- S3 bucket with lifecycle (STD -> IA 30d -> Glacier 180d)
- Logging bucket + server access logs
- SSE-KMS encryption + TLS-only policy
- Evaluate EFS vs FSx for workload notes

## Tasks Checklist
- [ ] Terraform S3 module created
- [ ] Lifecycle rules implemented
- [ ] Logging bucket + policy separation
- [ ] KMS CMK (alias) provisioned
- [ ] Public access block enforced
- [ ] Document cost impact

## Copilot Prompts
```
Terraform S3 module: variables (bucket_name_prefix, kms_key_arn, lifecycle_enabled bool); create logging bucket if create_logging = true; attach bucket policy forcing aws:SecureTransport.
```

## Validation
- `aws s3api get-bucket-policy`
- Lifecycle rules visible in console

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add replication (CRR) later
