# ADR-0001: Remote State & Locking

## Status
Proposed (Day 01)

## Context
Need reliable, encrypted, versioned Terraform remote state with team collaboration and locking.

## Decision
Use S3 bucket (private, versioning, SSE-KMS) + DynamoDB table for state locking. Naming pattern: `tfstate-<env>-<account>`.

## Rationale
- Native AWS, minimal cost
- Fine-grained IAM control
- KMS encryption alignment with security baseline

## Consequences
- Must manage bucket lifecycle & retention
- Need to handle replication manually if required for DR
- Access limited via IAM policy; requires updates for new teams

## Alternatives Considered
- Terraform Cloud: adds remote execution features but introduces external dependency
- Local state: not acceptable for team scale

## Follow-Up Actions
- Implement encryption key rotation policy (annual)
- Add replication to secondary region (future)
