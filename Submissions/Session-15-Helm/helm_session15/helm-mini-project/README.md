# Helm Session 15 Mini Project

A small production-style Helm chart for deploying an NGINX web application. It demonstrates Helm templating, configurable values, release revisions, upgrades, and rollback.

## Components

- `Deployment` — configurable replica count and image.
- `Service` — ClusterIP service on port 80.
- `ConfigMap` — generated HTML page containing the application version/message.
- `NOTES.txt` — post-install operational guidance.

## Prerequisites

- Kubernetes cluster
- `kubectl` configured for the target cluster
- Helm 4.x (Helm 3 is also compatible with the chart structure)

## Validate locally

```bash
helm lint ./helm-mini-project
helm template helm-session15 ./helm-mini-project
helm package ./helm-mini-project --destination ./artifacts
```

## Install

```bash
helm install session15 ./helm-mini-project
helm status session15
helm list
```

## Upgrade

```bash
helm upgrade session15 ./helm-mini-project \
  --set replicaCount=3 \
  --set app.version=2.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 2'
```

## Rollback

```bash
helm history session15
helm rollback session15 1
helm status session15
```

## Verify application

```bash
kubectl get pods,svc,deploy -l app.kubernetes.io/instance=session15
kubectl port-forward svc/session15-helm-session15-demo 8080:80
curl http://localhost:8080
```

## Cleanup

```bash
helm uninstall session15
```

See `../rollback-workflow/README.md` for the complete graded workflow.
