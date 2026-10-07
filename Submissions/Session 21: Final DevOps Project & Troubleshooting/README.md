# Final DevOps Project — Session 21

Complete end-to-end DevOps/DevSecOps learning project.

## Architecture

```text
Application -> Git -> GitHub -> GitHub Actions -> Test/SAST/SCA/Secret Scan
                                      |             |
                                      +----------> Docker -> GHCR -> Image Scan
                                                        |
                                      Terraform -> AWS EKS <- Helm <- GitOps/Argo CD
                                                        |
                                             Ingress/Service/Deployment
                                             ConfigMap/Secret/HPA/Probes/PVC
                                                        |
                                                Prometheus/Grafana
```

## Technologies
Python, Flask, Gunicorn, GitHub Actions, Docker, GHCR, Kubernetes, Helm, Terraform, AWS EKS, Semgrep, Trivy, Gitleaks, Prometheus, Grafana, Argo CD, NGINX Ingress, Metrics Server.

## Setup

### Application
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r application/requirements.txt
pytest -q application
python application/app.py
```

### Docker
```bash
docker build -f docker/Dockerfile -t final-devops-api:local .
docker run --rm -p 8080:8080 final-devops-api:local
```

### Kubernetes
Replace the placeholder GHCR image in `kubernetes/deployment.yaml`, then:
```bash
kubectl apply -k kubernetes/
kubectl get all -n final-devops
kubectl port-forward -n final-devops svc/final-devops-api 8080:80
curl http://localhost:8080/health
```

### Helm
```bash
helm lint helm/final-devops
helm upgrade --install final-devops helm/final-devops --namespace final-devops --create-namespace --set image.repository=ghcr.io/YOUR_GITHUB_USER/final-devops-project --set image.tag=latest
```

### Terraform / AWS EKS
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
aws eks update-kubeconfig --region ap-south-1 --name final-devops-eks
kubectl get nodes
```
Destroy after the lab: `terraform destroy`. AWS resources can incur charges.

## CI/CD
Pull requests run tests, Semgrep, Gitleaks, Trivy filesystem scanning and Helm lint. Pushes to `main` build/push the image to GHCR and run a container image scan. Security jobs are configured as gates by non-zero exit codes.

## DevSecOps
- SAST: Semgrep
- SCA/filesystem vulnerability scan: Trivy
- Secret scanning: Gitleaks
- Container scanning: Trivy
- Security gates: failed scan jobs block dependent image publishing.

## Monitoring
The API exposes `/metrics`. Install kube-prometheus-stack:
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```
Use `kubectl logs` and `kubectl top pods`; expose Grafana with port-forward in a learning environment.

## GitOps
Install Argo CD, edit `gitops/application.yaml` to point to your fork, and apply it. Argo CD watches `helm/final-devops`, then self-heals drift. For production, prefer immutable image digests and external secret management.

## Troubleshooting
Four intentionally broken examples live in `troubleshooting/broken/`: ImagePullBackOff, readiness failure, Service selector mismatch, and HPA metrics failure. Follow `troubleshooting/README.md` and record evidence in the report template.

## Screenshots
Create `docs/screenshots/` and add GitHub Actions, GHCR, Kubernetes, Helm, Grafana, Argo CD and Terraform evidence. Never include credentials/tokens.

## Lessons learned
Explain CI vs CD/GitOps, security gates, immutable images, probes, resource requests/HPA, Service selectors, observability, reproducible infrastructure, and secure secret handling.

## Production-hardening checklist
External Secrets, image signing/SBOM, GitHub OIDC to AWS, NetworkPolicies, PDBs, TLS, immutable digests, separate environments, remote Terraform state, centralized logs, alerting, backups, admission policies, dependency automation, and Argo CD RBAC/SSO.
