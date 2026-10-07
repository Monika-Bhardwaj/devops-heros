# Task 1 — Helm Commands Practice

## Execution note

This package was prepared in an execution environment that did **not** contain `helm`, `kubectl`, Docker, kind, or Minikube. Therefore, cluster-dependent commands could not be truthfully executed here. No fabricated terminal output is presented as real execution evidence.

Run `scripts/run_all.sh` (Linux/macOS) or `scripts/run_all.ps1` (PowerShell) from the project root to execute the commands on a configured Kubernetes cluster. The scripts save command output under `artifacts/`.

Helm's current stable major release is Helm 4; the chart uses standard Helm chart APIs and is intentionally simple enough to work with Helm 3/4. See the official command documentation for the exact CLI semantics.

## Command-by-command practice

| Command | What it does | Hands-on command | Evidence |
|---|---|---|---|
| `helm create` | Scaffolds a new chart directory with standard files/templates. | `helm create artifacts/scaffold-demo` | `artifacts/01-helm-create.txt` |
| `helm install` | Installs a chart as a named release into Kubernetes. | `helm install session15 ./helm-mini-project` | `artifacts/02-helm-install.txt` |
| `helm list` | Lists Helm releases in the selected namespace. | `helm list` | `artifacts/03-helm-list.txt` |
| `helm status` | Shows the current state and resources/notes for a release. | `helm status session15` | `artifacts/04-helm-status.txt` |
| `helm get` | Retrieves information stored for a release; useful subcommands include `all`, `values`, `manifest`, and `notes`. | `helm get all session15` | `artifacts/05-helm-get.txt` |
| `helm upgrade` | Applies a new chart/value configuration to an existing release and creates a new revision. | `helm upgrade session15 ./helm-mini-project --set app.version=2.0.0 --set app.message='Version 2' --set replicaCount=3` | `artifacts/06-helm-upgrade.txt` |
| `helm history` | Displays revisions and deployment status for a release. | `helm history session15` | `artifacts/07-helm-history.txt` |
| `helm rollback` | Restores a release to a previous revision. | `helm rollback session15 1` | `artifacts/08-helm-rollback.txt` |
| `helm uninstall` | Removes a release and its managed Kubernetes resources. | `helm uninstall session15` | `artifacts/09-helm-uninstall.txt` |
| `helm repo` | Manages chart repositories (`add`, `list`, `update`, `remove`). | `helm repo add bitnami https://charts.bitnami.com/bitnami && helm repo update && helm repo list` | `artifacts/10-helm-repo.txt` |
| `helm search` | Searches chart repositories or Artifact Hub. | `helm search repo nginx` | `artifacts/11-helm-search.txt` |

## Important observations

### 1. `helm create`
Creates a conventional chart scaffold. The generated chart is a starting point; production projects should remove unused templates and configure values deliberately.

### 2. `helm install`
Creates a named Helm release. Helm stores release state so later operations such as upgrade, history and rollback can refer to the release by name.

### 3. `helm list`
Shows releases visible in the current namespace by default. Use `-A` to inspect all namespaces when appropriate.

### 4. `helm status`
Useful for operational verification after install/upgrade/rollback. It also displays chart/release metadata and notes.

### 5. `helm get`
Use the subcommands to inspect what Helm knows about a release:

```bash
helm get all session15
helm get values session15
helm get manifest session15
helm get notes session15
```

### 6. `helm upgrade`
Changes the existing release and increments its revision. This is the core mechanism used in the rollback exercise.

### 7. `helm history`
Provides the revision trail needed to decide which revision to restore.

### 8. `helm rollback`
Restores a prior revision. A rollback itself creates a new revision; it does not erase the historical revisions.

### 9. `helm uninstall`
Deletes the release and its managed resources. Without `--keep-history`, the release history is normally removed as part of uninstall.

### 10. `helm repo`
Repositories are sources from which Helm can discover/install charts. `repo add`, `repo update`, `repo list`, and `repo remove` are common subcommands.

### 11. `helm search`
`helm search repo <keyword>` searches locally configured repositories. `helm search hub <keyword>` searches Artifact Hub.

## Expected evidence format

Each artifact should contain:

1. Exact command.
2. Timestamp.
3. Exit code.
4. Full stdout/stderr.
5. Short interpretation.

The supplied scripts generate this structure automatically.
