# Day 09 – Security & Compliance

## Objectives
- GuardDuty delegated admin + member enablement
- Inspector activation
- KMS CMK for app data
- Secrets Manager secret + rotation Lambda (scaffold)

## Tasks Checklist
- [ ] GuardDuty Terraform
- [ ] Inspector activation
- [ ] KMS key policy principle of least privilege
- [ ] Secrets Manager secret (auto-rotation 30d)

## Copilot Prompts
```
Terraform enabling GuardDuty org admin (account id var) + auto-enrollment new accounts; create detector for all available regions list variable.
```

## Validation
- GuardDuty detectors ACTIVE

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add SecurityHub integration
