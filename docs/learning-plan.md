# 14-Day Enterprise AWS Learning & Build Plan

(Tracking start date: 2025-09-11)

## Directory Map (Reference)
- `terraform/` modules + envs
- `k8s/` Helm charts, Argo CD apps, environment overlays
- `pocs/` Proof-of-concepts per topic
- `adr/` Architecture Decision Records
- `docs/` Knowledge, daily logs, designs
- `scripts/` Automation helpers

## Daily Plan Overview
Refer to `docs/daily/dXX-*.md` for deep details & checklists.

| Day | Theme | Key Outputs |
|-----|-------|-------------|
| 01 | Foundations & Remote State | Backend S3+Dynamo, IAM bootstrap, ADR-0001 |
| 02 | Networking (VPC) | VPC module, diagram, multi-tier subnets |
| 03 | IAM Strategy | Roles, Policies, SCP draft, ADR-0002 |
| 04 | Storage | S3 lifecycle, logging bucket, encryption notes |
| 05 | Compute (EC2/ASG/ALB) | ALB + ASG pattern, docs |
| 06 | Serverless & Eventing | Lambda + DynamoDB event POC |
| 07 | Data Layer | Aurora + Redis modules, ADR-0003 |
| 08 | Observability | Org CloudTrail, Config, alarms dashboard |
| 09 | Security & Compliance | GuardDuty, Inspector, KMS, secrets rotation |
| 10 | Cost Optimization | Budget alert, tag audit script |
| 11 | EKS Provision | EKS cluster + node group + IRSA |
| 12 | Add-ons & GitOps | ArgoCD, Helm add-ons, controllers |
| 13 | Delivery Strategy | Multi-env GitOps, canary rollout |
| 14 | Hardening & Review | Final docs, drift check, exec summary |

## AI Usage Pattern
Prompt structure: `Goal + Constraints + Output Format + Validation expectations`.
Examples:
- Terraform module: "Create Terraform module for multi-tier VPC (public/app/data) with variable az_count, produce outputs map by tier; include variable validation and tags input."
- IAM policy refinement: "Refactor to least privilege for EKS read-only; remove wildcard actions; justify each statement in comments."

## Acceptance Criteria (Global)
- Idempotent Terraform (plan clean after apply)
- Security: No public S3, IAM least privilege, IMDSv2 enforced
- Observability: >=5 meaningful alarms
- GitOps: ArgoCD managing workloads in EKS
- Cost governance: Budget + tagging baseline
- Documentation: ADRs + daily logs + final report

See `docs/final-report.md` after Day 14.
