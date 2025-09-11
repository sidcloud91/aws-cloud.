# aws-cloud

Enterprise AWS Skill Acceleration & Platform Build (14-Day Plan)

## Purpose
Structured, hands-on build to reach senior cloud engineer proficiency while constructing reusable Terraform modules, EKS platform, and GitOps workflow.

## Key Paths
- docs/learning-plan.md – Overview & index
- docs/daily/ – Daily execution checklists
- adr/ – Architecture Decision Records
- terraform/ – Infrastructure as Code (modules + envs)
- k8s/ – Kubernetes manifests, Helm charts, Argo CD apps
- pocs/ – Individual proof-of-concepts
- scripts/ – Utilities (tag audits, helpers)

## Quick Start (Planned)
1. Configure AWS credentials (least privilege role for terraform).
2. Create/confirm remote state backend (Day 01 steps).
3. Execute environment build in `terraform/envs/dev` (to be added).
4. Provision EKS (Day 11) then deploy add-ons (Day 12) via ArgoCD.

## Progress Tracking
Update corresponding `docs/daily/dXX-*.md` file after completing tasks. Mark checkboxes and add notes.

## ADRs
See `adr/README.md` for decisions list.

## Final Report
Will be generated in `docs/final-report.md` on Day 14.