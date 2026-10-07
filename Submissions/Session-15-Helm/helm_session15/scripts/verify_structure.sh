#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
required=(
  "$ROOT/helm-mini-project/Chart.yaml"
  "$ROOT/helm-mini-project/values.yaml"
  "$ROOT/helm-mini-project/templates/_helpers.tpl"
  "$ROOT/helm-mini-project/templates/deployment.yaml"
  "$ROOT/helm-mini-project/templates/service.yaml"
  "$ROOT/helm-mini-project/templates/configmap.yaml"
  "$ROOT/helm-mini-project/templates/NOTES.txt"
  "$ROOT/command-practice/README.md"
  "$ROOT/rollback-workflow/README.md"
  "$ROOT/scripts/run_all.sh"
  "$ROOT/scripts/run_all.ps1"
)
for f in "${required[@]}"; do
  test -f "$f" || { echo "MISSING: $f"; exit 1; }
done
printf 'Static project structure: PASS\n'
