# Day 13 – Delivery Strategy

## Objectives
- Multi-env (dev/prod) GitOps structure
- Canary rollout (Argo Rollouts) for sample app
- Kustomize/Helm overlays differences (replicas, resources)

## Tasks Checklist
- [ ] k8s/envs/dev overlay
- [ ] k8s/envs/prod overlay
- [ ] ArgoCD Applications per env
- [ ] Rollout manifest canary steps

## Copilot Prompts
```
Kustomize overlay adding env-specific replica count and configmap patch.
```
```
Argo Rollout manifest: canary strategy steps 20%, pause, 50%, pause, 100% promote; include analysis template placeholder.
```

## Validation
- `kubectl argo rollouts get rollout <name>` shows progressing

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add progressive metrics analysis integration
