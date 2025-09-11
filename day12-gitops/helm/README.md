# Day 12 - Helm Charts

## Helm Charts for EKS Add-ons

Helm chart configurations for cluster add-ons.

### Charts to configure:
- ArgoCD (core GitOps platform)
- AWS Load Balancer Controller
- External DNS
- Cluster Autoscaler
- Metrics Server

### Chart Structure:
```
helm/
├── argocd/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
├── aws-load-balancer-controller/
│   └── values.yaml
└── nginx-sample/
    ├── Chart.yaml
    └── values.yaml
```

### IRSA Integration:
All controllers configured with IAM Roles for Service Accounts.

*Helm configurations for Day 12.*
