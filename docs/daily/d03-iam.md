# Day 03 – IAM Strategy

## Objectives
- Roles: platform-admin, read-only, ci-deployer
- Policies with least privilege & boundary policy concept
- Initial SCP draft (deny untagged resource creation)
- ADR-0002 (IAM Strategy)

## Tasks Checklist
- [ ] Create roles + trust policies
- [ ] Inline/managed policies (JSON in terraform)
- [ ] SCP draft (document only if org not accessible)
- [ ] Access Analyzer evaluation
- [ ] ADR-0002 committed

## Copilot Prompts
```
Terraform IAM role 'platform-admin' assuming from federated principal (placeholder) with inline policy: full read, limited write (no IAM * deletion, no kms:ScheduleKeyDeletion).
```
```
SCP denying ec2:RunInstances unless request includes tag keys: Owner, CostCenter; include condition examples.
```

## Validation
- IAM Policy Simulator test for deny condition

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Federation integration with corporate IdP next phase
