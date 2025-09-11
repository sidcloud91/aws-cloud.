# Day 12 – Add-ons & GitOps

## Objectives
- Install ArgoCD (Helm)
- Add-ons: aws-load-balancer-controller, external-dns, cluster-autoscaler
- IRSA roles for controllers

## Tasks Checklist
- [ ] Helm chart references & values
- [ ] ArgoCD install
- [ ] Application manifests (app-of-apps pattern optional)
- [ ] ALB created for sample ingress

## Copilot Prompts
```
Helm values snippet for aws-load-balancer-controller enabling WAF attachment and setting region variable.
```
```
ArgoCD Application manifest referencing repo root path k8s/helm/nginx; syncPolicy automated prune selfHeal.
```

## Validation
- `kubectl get pods -n argocd` healthy
- ALB Ingress address available

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add cert-manager & ACM integration
