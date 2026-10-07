#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHART="$ROOT/helm-mini-project"
ART="$ROOT/artifacts"
RELEASE="session15"
NS="default"
mkdir -p "$ART"

run_capture() {
  local id="$1"; shift
  local file="$ART/${id}.txt"
  {
    echo "============================================================"
    echo "COMMAND: $*"
    echo "TIMESTAMP: $(date -Is)"
    echo "============================================================"
    set +e
    "$@"
    rc=$?
    set -e
    echo
    echo "EXIT_CODE: $rc"
    if [[ $rc -ne 0 ]]; then
      echo "RESULT: FAILED"
      return $rc
    fi
    echo "RESULT: SUCCESS"
  } 2>&1 | tee "$file"
}

cd "$ROOT"

echo "Session 15 Helm evidence capture"
echo "Root: $ROOT"
echo "Chart: $CHART"

run_capture 00-helm-version helm version
run_capture 00-kubectl-context kubectl config current-context
run_capture 00-kubectl-nodes kubectl get nodes

rm -rf "$ART/scaffold-demo"
run_capture 01-helm-create helm create "$ART/scaffold-demo"
run_capture 01-helm-lint helm lint "$CHART"
run_capture 01-helm-template helm template "$RELEASE" "$CHART"
run_capture 01-helm-package helm package "$CHART" --destination "$ART"

# Repository/search practice.
run_capture 10-helm-repo-add helm repo add bitnami https://charts.bitnami.com/bitnami
run_capture 10-helm-repo-update helm repo update
run_capture 10-helm-repo-list helm repo list
run_capture 11-helm-search helm search repo nginx

# Start clean for the release lifecycle.
helm uninstall "$RELEASE" -n "$NS" --ignore-not-found >/dev/null 2>&1 || true

run_capture 02-helm-install helm install "$RELEASE" "$CHART" -n "$NS" \
  --set replicaCount=2 \
  --set app.version=1.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 1'
run_capture 03-helm-list helm list -n "$NS"
run_capture 04-helm-status helm status "$RELEASE" -n "$NS"
run_capture 05-helm-get-all helm get all "$RELEASE" -n "$NS"
run_capture 05-helm-get-values helm get values "$RELEASE" -n "$NS"
run_capture 05-helm-get-manifest helm get manifest "$RELEASE" -n "$NS"

run_capture 06-helm-upgrade-v2 helm upgrade "$RELEASE" "$CHART" -n "$NS" \
  --set replicaCount=3 \
  --set app.version=2.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 2'
run_capture 06-verify-v2 helm status "$RELEASE" -n "$NS"
run_capture 07-helm-history-v2 helm history "$RELEASE" -n "$NS"

run_capture 08-helm-upgrade-v3 helm upgrade "$RELEASE" "$CHART" -n "$NS" \
  --set replicaCount=4 \
  --set app.version=3.0.0 \
  --set app.message='Hello from Helm Session 15 - Version 3'
run_capture 08-verify-v3 helm status "$RELEASE" -n "$NS"
run_capture 09-helm-history-v3 helm history "$RELEASE" -n "$NS"
run_capture 09-kubectl-before-rollback kubectl get deploy,pods,svc -n "$NS" -l app.kubernetes.io/instance="$RELEASE"

run_capture 10-helm-rollback helm rollback "$RELEASE" 2 -n "$NS"
run_capture 11-helm-history-after-rollback helm history "$RELEASE" -n "$NS"
run_capture 12-helm-status-after-rollback helm status "$RELEASE" -n "$NS"
run_capture 12-helm-values-after-rollback helm get values "$RELEASE" -n "$NS"
run_capture 12-kubectl-after-rollback kubectl get deploy,pods,svc -n "$NS" -l app.kubernetes.io/instance="$RELEASE"

# Optional functional check if curl is available and the user starts port-forward separately.
cat > "$ART/12-functional-check.txt" <<'NOTE'
Functional verification:
  kubectl port-forward svc/session15-helm-session15-demo 8080:80
  curl http://localhost:8080
Expected after rollback:
  Hello from Helm Session 15 - Version 2
  Application version: 2.0.0
NOTE

run_capture 13-helm-uninstall helm uninstall "$RELEASE" -n "$NS"
run_capture 14-helm-list-after-uninstall helm list -n "$NS" --all

cat > "$ART/EXECUTION_SUMMARY.txt" <<EOF2
Execution completed at: $(date -Is)
Release: $RELEASE
Namespace: $NS
Rollback target: revision 2
Expected post-rollback state: replicaCount=3, app.version=2.0.0
See individual .txt files for exact command output and exit codes.
EOF2

echo
 echo "Evidence capture complete. Review: $ART"
