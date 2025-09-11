# Day 11 – EKS Provision

## Objectives
- EKS cluster (Terraform) with managed node group
- IRSA OIDC provider
- Cluster logging enabled (api,audit,authenticator)

## Tasks Checklist
- [ ] Terraform eks module skeleton
- [ ] Node group Bottlerocket / Amazon Linux 2
- [ ] IRSA for metrics-server
- [ ] Outputs: cluster_name, endpoint, oidc_provider_arn

## Copilot Prompts
```
Terraform EKS cluster with irsa enabled; managed node group min=2,max=5; labels env=dev; attach policy AmazonEKS_CNI_Policy via node role.
```

## Validation
- `aws eks update-kubeconfig` success
- `kubectl get nodes`

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add Fargate profile for system pods
