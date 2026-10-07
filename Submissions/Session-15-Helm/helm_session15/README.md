# Session 15 — Helm Complete Submission

## Deliverables

This folder contains:

- `helm-mini-project/` — complete Helm chart.
- `command-practice/README.md` — Task 1 command-by-command guide.
- `rollback-workflow/README.md` — Task 2 complete install/upgrade/verify/upgrade/verify/rollback/verify workflow.
- `scripts/run_all.sh` — Linux/macOS automation and evidence capture.
- `scripts/run_all.ps1` — Windows PowerShell automation and evidence capture.
- `screenshots/README.md` — screenshot checklist and naming convention.
- `artifacts/` — generated evidence location; this package contains only environment notes until run against a cluster.

## Environment limitation during preparation

The build environment used to assemble this submission did not have `helm`, `kubectl`, Docker, kind, or Minikube installed. Therefore, Kubernetes-mutating operations (`install`, `upgrade`, `status`, `get`, `history`, `rollback`, `uninstall`) were **not executed here**, and no fake execution results are represented as real evidence.

The chart files, commands, workflow, and automation are complete and designed for execution on a local or remote Kubernetes cluster.

## Recommended local setup

1. Install Helm 4.x.
2. Install/configure `kubectl`.
3. Start a Kubernetes cluster (Docker Desktop Kubernetes, Minikube, kind, or a remote cluster).
4. Verify:

```bash
helm version
kubectl cluster-info
kubectl get nodes
```

5. From this project root, run:

Linux/macOS:

```bash
chmod +x scripts/run_all.sh
./scripts/run_all.sh
```

Windows PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\scripts\run_all.ps1
```

## Submission structure

```text
Session-15-Helm/
├── README.md
├── helm-mini-project/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── .helmignore
│   ├── README.md
│   └── templates/
│       ├── _helpers.tpl
│       ├── configmap.yaml
│       ├── deployment.yaml
│       ├── service.yaml
│       └── NOTES.txt
├── command-practice/
│   └── README.md
├── rollback-workflow/
│   └── README.md
├── scripts/
│   ├── run_all.sh
│   └── run_all.ps1
├── screenshots/
│   └── README.md
└── artifacts/
    └── README.md
```

## Learning outcomes

By completing the supplied runbook, you demonstrate:

- Helm chart creation and structure.
- Values-driven templating.
- Release installation and inspection.
- Repository discovery/search.
- Safe upgrades and revision tracking.
- Rollback to a known-good revision.
- Verification at both Helm and Kubernetes levels.
- Evidence capture suitable for a lab submission.
