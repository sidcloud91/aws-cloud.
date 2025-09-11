# Day 06 – Serverless & Eventing

## Objectives
- Lambda (Python) triggered by S3 Put
- DynamoDB table (TTL) storing metadata
- IAM execution role least privilege

## Tasks Checklist
- [ ] Lambda code scaffold
- [ ] S3 event notification -> Lambda
- [ ] DynamoDB table w/ TTL attr (expires_at)
- [ ] IAM policy restricting only PutItem/GetItem

## Copilot Prompts
```
Python Lambda handler validating object content-type starts with image/ then writes item {id (uuid), key, size, content_type, timestamp, expires_at} to DynamoDB; use boto3.
```

## Validation
- Upload test object -> CloudWatch Logs entry

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add DLQ (SQS) for failures
