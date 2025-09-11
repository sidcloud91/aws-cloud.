# Day 10 – Cost Optimization

## Objectives
- AWS Budget (monthly threshold)
- Tag audit PowerShell script (missing Owner, CostCenter)
- Rightsizing notes (Compute, RDS)

## Tasks Checklist
- [ ] Budget Terraform
- [ ] Script: `scripts/tag_audit.ps1`
- [ ] Document tag standard

## Copilot Prompts
```
PowerShell script using AWS CLI: list EC2 instances; output CSV of instances missing required tags [Owner, CostCenter, Env].
```

## Validation
- Run script -> CSV generated

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Evaluate Savings Plans post baseline usage
