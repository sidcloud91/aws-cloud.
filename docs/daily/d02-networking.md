# Day 02 – Networking (VPC Core)

## Objectives
- Design multi-AZ VPC with public/app/data subnets
- NAT Gateways (cost note) + endpoints (S3, SSM)
- Terraform VPC module creation
- Network diagram

## Tasks Checklist
- [ ] Define CIDR plan (document)
- [ ] Implement VPC module (variables: cidr_block, az_count, subnet_tiers)
- [ ] Add route tables & associations
- [ ] Add NAT Gateways (public subnets)
- [ ] Add Gateway + Interface endpoints
- [ ] Outputs: subnet_ids by tier, route_table_ids, vpc_id
- [ ] Diagram saved to `docs/network-v1.drawio`

## Copilot Prompts
```
Terraform module for multi-tier VPC: inputs (cidr_block, az_count, common_tags map, subnet_tiers = ["public","app","data"]); create one subnet per AZ per tier; output map(tier=>list(subnet_ids)). Enforce no public ACLs.
```
```
Add VPC endpoints: S3 (gateway), SSM + SSMMessages (interface) with security group restricting to private subnets.
```

## Validation
- `terraform plan` clean
- Reachability Analyzer (console) test from app subnet to SSM endpoint

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Consider central egress via Transit Gateway later
