# Day 05 – Compute (EC2 / ASG / ALB)

## Objectives
- Launch template (IMDSv2, gp3, latest AMI data source)
- ASG with target tracking scaling policy (CPU 50%)
- ALB + listener + target group (health check /)
- Document stateless pattern & scaling strategy

## Tasks Checklist
- [ ] Launch template Terraform
- [ ] ASG + scaling policy
- [ ] ALB + SG (80/443) + target group
- [ ] Outputs: alb_dns_name
- [ ] Doc compute-patterns

## Copilot Prompts
```
Terraform: launch template enforcing metadata_options http_tokens=required; ASG across private subnets; ALB in public subnets; target tracking policy average CPU 50%.
```

## Validation
- Curl ALB DNS returns 200 (placeholder app)

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add HTTPS + ACM cert later
