# Final Troubleshooting Challenge

Use evidence, not guesses. For each fault: identify symptom, inspect resources/logs/events, determine root cause, fix, verify, document prevention.

## 1. ImagePullBackOff
Commands: `kubectl get pods -n final-devops`, `kubectl describe pod <pod> -n final-devops`. Root cause: invalid/inaccessible image. Fix repository/tag/registry access.

## 2. Readiness probe failure
Commands: `kubectl describe pod <pod> -n final-devops`, `kubectl logs <pod> -n final-devops`. Root cause: wrong path/port. Fix to `/ready:8080`.

## 3. Service selector mismatch
Command: `kubectl get endpoints final-devops-api -n final-devops`. Root cause: selector does not match pod labels. Fix selector.

## 4. HPA metrics failure
Commands: `kubectl describe hpa final-devops-api -n final-devops`, `kubectl top pods -n final-devops`, `kubectl get apiservice | grep metrics`. Root cause: Metrics Server unavailable or CPU requests missing. Fix metrics and requests.

See `report-template.md`. Broken examples are under `broken/`.
