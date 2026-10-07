# Task 2 — Complete Helm Rollback Workflow

This exercise intentionally creates **three meaningful application revisions** so the rollback is easy to verify.

## Revision plan

| Revision | Change | Expected state |
|---|---|---|
| 1 | Initial install | 2 replicas, app version 1.0.0, message Version 1 |
| 2 | First upgrade | 3 replicas, app version 2.0.0, message Version 2 |
| 3 | Second upgrade | 4 replicas, app version 3.0.0, message Version 3 |
| 4 | Rollback to revision 2 | Restores Version 2 configuration |

> Important: after `helm rollback session15 2`, Helm creates a **new revision** (revision 4 in this sequence) whose effective configuration matches revision 2.

## Step 0 — Clean starting point

```bash
helm uninstall session15 --ignore-not-found
```

## Step 1 — Install

```bash
helm install session15 ./helm-mini-project \
  --set replicaCount=2 \
  --set app.version=1.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 1'
```

Verify:

```bash
helm status session15
helm get values session15
kubectl get deploy,pods,svc -l app.kubernetes.io/instance=session15
```

Expected application configuration: **2 replicas / Version 1**.

## Step 2 — Upgrade

```bash
helm upgrade session15 ./helm-mini-project \
  --set replicaCount=3 \
  --set app.version=2.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 2'
```

Verify:

```bash
helm status session15
helm history session15
helm get values session15
kubectl get deploy,pods -l app.kubernetes.io/instance=session15
```

Expected application configuration: **3 replicas / Version 2**.

## Step 3 — Upgrade again

```bash
helm upgrade session15 ./helm-mini-project \
  --set replicaCount=4 \
  --set app.version=3.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 3'
```

Verify:

```bash
helm status session15
helm history session15
helm get values session15
kubectl get deploy,pods -l app.kubernetes.io/instance=session15
```

Expected application configuration: **4 replicas / Version 3**.

## Step 4 — Rollback

Rollback to revision 2:

```bash
helm rollback session15 2
```

Verify the new revision and effective configuration:

```bash
helm history session15
helm status session15
helm get values session15
kubectl get deploy,pods -l app.kubernetes.io/instance=session15
```

Expected application configuration after rollback: **3 replicas / Version 2**.

## Step 5 — Functional verification

```bash
kubectl port-forward svc/session15-helm-session15-demo 8080:80
```

In another terminal:

```bash
curl http://localhost:8080
```

The returned HTML should contain:

```text
Hello from Helm Session 15 - Version 2
Application version: 2.0.0
```

## Evidence checklist

- [ ] Install output
- [ ] Revision 1 status
- [ ] First upgrade output
- [ ] Revision 2 status
- [ ] Second upgrade output
- [ ] Revision 3 status
- [ ] `helm history` before rollback
- [ ] Rollback output
- [ ] `helm history` after rollback showing a new revision
- [ ] Revision 4 status
- [ ] `kubectl get pods` showing 3 replicas after rollback
- [ ] Browser/curl output showing Version 2 after rollback

The automation scripts in `scripts/` capture these outputs into `artifacts/`.
