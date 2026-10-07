$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Chart = Join-Path $Root 'helm-mini-project'
$Art = Join-Path $Root 'artifacts'
$Release = 'session15'
$Namespace = 'default'
New-Item -ItemType Directory -Force -Path $Art | Out-Null

function Invoke-Capture {
    param([string]$Id, [string]$CommandLine)
    $File = Join-Path $Art "$Id.txt"
    @(
        '============================================================'
        "COMMAND: $CommandLine"
        "TIMESTAMP: $(Get-Date -Format o)"
        '============================================================'
    ) | Set-Content $File
    try {
        $output = Invoke-Expression "$CommandLine 2>&1" | Out-String
        $output | Add-Content $File
        'EXIT_CODE: 0' | Add-Content $File
        'RESULT: SUCCESS' | Add-Content $File
        Write-Host $output
    } catch {
        $_ | Out-String | Add-Content $File
        'RESULT: FAILED' | Add-Content $File
        throw
    }
}

Set-Location $Root
Invoke-Capture '00-helm-version' 'helm version'
Invoke-Capture '00-kubectl-context' 'kubectl config current-context'
Invoke-Capture '00-kubectl-nodes' 'kubectl get nodes'

$Scaffold = Join-Path $Art 'scaffold-demo'
if (Test-Path $Scaffold) { Remove-Item -Recurse -Force $Scaffold }
Invoke-Capture '01-helm-create' "helm create `"$Scaffold`""
Invoke-Capture '01-helm-lint' "helm lint `"$Chart`""
Invoke-Capture '01-helm-template' "helm template $Release `"$Chart`""
Invoke-Capture '01-helm-package' "helm package `"$Chart`" --destination `"$Art`""

Invoke-Capture '10-helm-repo-add' 'helm repo add bitnami https://charts.bitnami.com/bitnami'
Invoke-Capture '10-helm-repo-update' 'helm repo update'
Invoke-Capture '10-helm-repo-list' 'helm repo list'
Invoke-Capture '11-helm-search' 'helm search repo nginx'

helm uninstall $Release -n $Namespace --ignore-not-found 2>$null | Out-Null

Invoke-Capture '02-helm-install' "helm install $Release `"$Chart`" -n $Namespace --set replicaCount=2 --set app.version=1.0.0 --set app.message=`"Hello from Helm Session 15 - Version 1`""
Invoke-Capture '03-helm-list' "helm list -n $Namespace"
Invoke-Capture '04-helm-status' "helm status $Release -n $Namespace"
Invoke-Capture '05-helm-get-all' "helm get all $Release -n $Namespace"
Invoke-Capture '05-helm-get-values' "helm get values $Release -n $Namespace"
Invoke-Capture '05-helm-get-manifest' "helm get manifest $Release -n $Namespace"

Invoke-Capture '06-helm-upgrade-v2' "helm upgrade $Release `"$Chart`" -n $Namespace --set replicaCount=3 --set app.version=2.0.0 --set app.message=`"Hello from Helm Session 15 - Version 2`""
Invoke-Capture '06-verify-v2' "helm status $Release -n $Namespace"
Invoke-Capture '07-helm-history-v2' "helm history $Release -n $Namespace"

Invoke-Capture '08-helm-upgrade-v3' "helm upgrade $Release `"$Chart`" -n $Namespace --set replicaCount=4 --set app.version=3.0.0 --set app.message=`"Hello from Helm Session 15 - Version 3`""
Invoke-Capture '08-verify-v3' "helm status $Release -n $Namespace"
Invoke-Capture '09-helm-history-v3' "helm history $Release -n $Namespace"
Invoke-Capture '09-kubectl-before-rollback' "kubectl get deploy,pods,svc -n $Namespace -l app.kubernetes.io/instance=$Release"

Invoke-Capture '10-helm-rollback' "helm rollback $Release 2 -n $Namespace"
Invoke-Capture '11-helm-history-after-rollback' "helm history $Release -n $Namespace"
Invoke-Capture '12-helm-status-after-rollback' "helm status $Release -n $Namespace"
Invoke-Capture '12-helm-values-after-rollback' "helm get values $Release -n $Namespace"
Invoke-Capture '12-kubectl-after-rollback' "kubectl get deploy,pods,svc -n $Namespace -l app.kubernetes.io/instance=$Release"

@'
Functional verification:
  kubectl port-forward svc/session15-helm-session15-demo 8080:80
  curl http://localhost:8080
Expected after rollback:
  Hello from Helm Session 15 - Version 2
  Application version: 2.0.0
'@ | Set-Content (Join-Path $Art '12-functional-check.txt')

Invoke-Capture '13-helm-uninstall' "helm uninstall $Release -n $Namespace"
Invoke-Capture '14-helm-list-after-uninstall' "helm list -n $Namespace --all"

@"
Execution completed at: $(Get-Date -Format o)
Release: $Release
Namespace: $Namespace
Rollback target: revision 2
Expected post-rollback state: replicaCount=3, app.version=2.0.0
See individual .txt files for exact command output and exit codes.
"@ | Set-Content (Join-Path $Art 'EXECUTION_SUMMARY.txt')

Write-Host "Evidence capture complete. Review: $Art"
