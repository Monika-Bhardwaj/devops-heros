# Screenshot Evidence Checklist

Because the preparation environment had no Kubernetes/Helm runtime, actual cluster screenshots must be captured during the hands-on run. Do not submit simulated screenshots as if they were real execution evidence.

Recommended screenshots:

1. `01-helm-create.png` — terminal showing `helm create` completion and generated chart directory.
2. `02-helm-install.png` — `helm install` output.
3. `03-helm-list.png` — `helm list` showing `session15`.
4. `04-helm-status.png` — `helm status session15`.
5. `05-helm-get.png` — `helm get values` or `helm get all`.
6. `06-helm-upgrade-v2.png` — first upgrade output.
7. `07-helm-history-v2.png` — history showing revisions 1 and 2.
8. `08-helm-upgrade-v3.png` — second upgrade output.
9. `09-helm-history-v3.png` — history showing revisions 1, 2, 3.
10. `10-helm-rollback.png` — rollback command and output.
11. `11-helm-history-after-rollback.png` — history showing the new rollback revision.
12. `12-rollback-verification.png` — `kubectl get` plus application output showing Version 2 restored.
13. `13-helm-repo-search.png` — `helm repo list` and `helm search repo nginx`.
14. `14-helm-uninstall.png` — `helm uninstall` output and final `helm list`.

## Screenshot quality

Capture the command and enough output to establish the release name, revision, status, and changed values. Avoid cropping away the command itself.
