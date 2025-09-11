# aws-cloud

Enterprise AWS Skill Acceleration & Platform Build (14-Day Plan)

## Purpose
Structured, hands-on build to reach senior cloud engineer proficiency while constructing reusable Terraform modules, EKS platform, and GitOps workflow.

## 📊 Progress Tracking
See `PROGRESS.md` for daily progress dashboard and milestone tracking.

## 📁 Repository Structure (Day-Wise Organization)

### Core Documentation
- `docs/learning-plan.md` – Master 14-day plan overview
- `docs/daily/` – Daily execution checklists and logs
- `adr/` – Architecture Decision Records
- `PROGRESS.md` – Progress tracker dashboard

### Day-Wise Implementation
```
📂 day01-foundations/     # Remote state, IAM bootstrap
📂 day02-networking/      # VPC, subnets, routing
📂 day03-iam/            # IAM strategy, roles, policies
📂 day04-storage/        # S3, lifecycle, encryption
📂 day05-compute/        # EC2, ASG, ALB
📂 day06-serverless/     # Lambda, DynamoDB, events
📂 day07-data/           # Aurora, Redis, caching
📂 day08-observability/  # CloudTrail, Config, monitoring
📂 day09-security/       # GuardDuty, Inspector, KMS
📂 day10-cost/           # Budgets, cost optimization
📂 day11-eks/            # EKS cluster provisioning
📂 day12-gitops/         # ArgoCD, Helm, add-ons
📂 day13-delivery/       # Multi-env GitOps strategy
📂 day14-hardening/      # Security review, final docs
```

Each day folder contains:
- `terraform/` - Infrastructure as Code
- `k8s/` or `helm/` - Kubernetes manifests (where applicable)
- `scripts/` - Automation utilities (where applicable)
- `README.md` - Day-specific guidance

## 🚀 Quick Start
1. **Review Progress**: Check `PROGRESS.md` for current status
2. **Start Day 01**: Navigate to `day01-foundations/` 
3. **Follow Daily Plans**: Use `docs/daily/d01-foundations.md` for tasks
4. **Update Progress**: Mark completion in `PROGRESS.md`

## 🎯 Daily Workflow
1. Review `docs/daily/dXX-*.md` for objectives and tasks
2. Work in corresponding `dayXX-*/` directory
3. Update `PROGRESS.md` with completion status
4. Commit changes with descriptive messages

## 📋 Key Deliverables
- ✅ 14 days of hands-on AWS implementations
- 🏗️ Production-ready Terraform modules
- ⚓ EKS cluster with GitOps workflow
- 📖 Comprehensive documentation
- 🔒 Security and compliance baseline
- 💰 Cost optimization framework

## 🔗 Quick Links
- [Learning Plan](docs/learning-plan.md)
- [Progress Tracker](PROGRESS.md)
- [ADR Index](adr/README.md)
- [Final Report](docs/final-report.md)