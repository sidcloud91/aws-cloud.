# Day 14 – Hardening & Review

## Objectives
- Security + cost review
- Drift detection (terraform plan)
- Final documentation & executive summary
- Chaos test (delete pod) verifying self-healing

## Tasks Checklist
- [ ] Terraform drift check
- [ ] IAM least privilege review
- [ ] S3 public access audit
- [ ] Final README updates
- [ ] Final architecture diagram
- [ ] Exec summary in `docs/final-report.md`

## Copilot Prompts
```
Summarize project architecture into executive report section with components: Networking, Security, Observability, Data, Platform (EKS + GitOps), Governance. Include bullet risk list.
```

## Validation
- `terraform plan` no changes
- `kubectl delete pod` test passes (pod recreated)

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add OPA/Gatekeeper policies
