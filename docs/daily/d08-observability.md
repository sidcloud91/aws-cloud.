# Day 08 – Observability

## Objectives
- Organization CloudTrail (all regions, S3 encrypted)
- AWS Config recorder + conformance packs (note)
- CloudWatch dashboard + alarms (ALB 5xx, latency p95, Lambda errors)
- SNS topic for alarms

## Tasks Checklist
- [ ] Trail Terraform
- [ ] Config recorder + delivery channel
- [ ] Alarms + dashboard JSON resource
- [ ] SNS topic + subscription (email placeholder)

## Copilot Prompts
```
Terraform CloudWatch metric alarms: 1) ALB 5XXErrorRate >5% 5m; 2) TargetResponseTime p95 > 0.8s; composite alarm referencing both.
```

## Validation
- Alarms state = OK initially

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add log aggregation to OpenSearch later
