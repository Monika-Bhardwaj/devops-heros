# Session 12: Kubernetes Ingress, ConfigMaps & Secrets

## Overview

This session demonstrates important Kubernetes concepts used for application deployment and management:

- ConfigMaps for storing non-sensitive configuration.
- Secrets for storing sensitive information.
- Pods and environment variable injection.
- Services for exposing applications inside the cluster.
- Ingress for HTTP/HTTPS routing.
- Ingress Controllers for implementing routing rules.
- Kubernetes troubleshooting using `kubectl`.

---

# Task 1: ConfigMap

## Objective

The objective of this task is to create a Kubernetes ConfigMap, store application configuration values, inject the values into a Pod, and verify them inside the container.

## 1. Create ConfigMap

The following ConfigMap stores configuration values for the Yatri application.

### `app-config.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: yatri-app-config
  labels:
    app: yatri-backend
data:
  DEFAULT_CURRENCY: "INR"
  ENVIRONMENT: "production"
  LOG_LEVEL: "INFO"
  MAX_BOOKING_DAYS: "30"
  PORT: "5000"
```

The ConfigMap contains five configuration values:

| Key | Value |
|---|---|
| DEFAULT_CURRENCY | INR |
| ENVIRONMENT | production |
| LOG_LEVEL | INFO |
| MAX_BOOKING_DAYS | 30 |
| PORT | 5000 |

## 2. Apply ConfigMap

Run:

```bash
kubectl apply -f app-config.yaml
```

Expected output:

```text
configmap/yatri-app-config created
```

## 3. Verify ConfigMap

Run:

```bash
kubectl get configmap yatri-app-config
```

Expected output:

```text
NAME                DATA   AGE
yatri-app-config    5      ...
```

## 4. Describe ConfigMap

Run:

```bash
kubectl describe configmap yatri-app-config
```

The output displays the configuration values stored in the ConfigMap.

### Screenshot: ConfigMap Demonstration

![ConfigMap Demo](screenshots/01-configmap-demo.png)

The screenshot shows the successful creation, retrieval, and description of `yatri-app-config`.

It verifies the following configuration values:

```text
DEFAULT_CURRENCY: INR
ENVIRONMENT: production
LOG_LEVEL: INFO
MAX_BOOKING_DAYS: 30
PORT: 5000
```

## 5. Inject ConfigMap into a Pod

The ConfigMap can be injected into a Pod as environment variables.

### `config-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: yatri-config-pod
spec:
  containers:
    - name: app
      image: busybox:1.36
      command: ["sh", "-c", "env; sleep 3600"]
      envFrom:
        - configMapRef:
            name: yatri-app-config
```

Apply the Pod:

```bash
kubectl apply -f config-pod.yaml
```

Verify the values inside the container:

```bash
kubectl exec yatri-config-pod -- env
```

Expected values:

```text
DEFAULT_CURRENCY=INR
ENVIRONMENT=production
LOG_LEVEL=INFO
MAX_BOOKING_DAYS=30
PORT=5000
```

This confirms that the ConfigMap values were successfully injected into the container.

---

# Task 2: Secret

## Objective

The objective of this task is to create a Kubernetes Secret, store a sensitive value, inject the Secret into a Pod, and verify the value inside the container.

Secrets can be used for sensitive information such as:

- Database passwords
- API keys
- Authentication credentials
- Tokens
- Certificates

## 1. Create Secret

### `db-secret.yaml`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: yatri-db-secret
type: Opaque
stringData:
  POSTGRES_PASSWORD: "secretpassword"
```

Apply the Secret:

```bash
kubectl apply -f db-secret.yaml
```

Expected output:

```text
secret/yatri-db-secret created
```

## 2. Verify Secret

Run:

```bash
kubectl get secret yatri-db-secret
```

Expected output:

```text
NAME               TYPE     DATA   AGE
yatri-db-secret    Opaque   1      ...
```

## 3. Decode and Verify the Secret

Run:

```bash
kubectl get secret yatri-db-secret \
  -o jsonpath='{.data.POSTGRES_PASSWORD}' | base64 --decode
```

Expected output:

```text
secretpassword
```

### Screenshot: Secret Demonstration

![Secret Demo](screenshots/02-secret-demo.png)

The screenshot shows:

```bash
kubectl apply -f db-secret.yaml
```

followed by:

```bash
kubectl get secret yatri-db-secret
```

and the command used to decode the stored password.

## 4. Inject Secret into a Pod

### `secret-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: yatri-secret-pod
spec:
  containers:
    - name: app
      image: busybox:1.36
      command: ["sh", "-c", "echo $POSTGRES_PASSWORD; sleep 3600"]
      env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: yatri-db-secret
              key: POSTGRES_PASSWORD
```

Apply:

```bash
kubectl apply -f secret-pod.yaml
```

Verify the value inside the container:

```bash
kubectl exec yatri-secret-pod -- printenv POSTGRES_PASSWORD
```

Expected output:

```text
secretpassword
```

This confirms that the Secret was successfully injected into the container.

## Why Secrets Should Not Be Committed Directly to Git

Sensitive information should not be committed directly to Git repositories.

Reasons include:

1. Git stores commit history, so deleted secrets may still exist in previous commits.
2. Public repositories can expose passwords and credentials.
3. Other developers or systems may clone the repository.
4. Compromised credentials can provide unauthorized access.
5. Secrets may be copied into backups and forks.
6. Security scanners can detect leaked credentials.

Although Kubernetes Secrets provide a standard mechanism for storing sensitive data, a Secret should not be treated as automatically secure simply because its values are Base64 encoded.

**Base64 encoding is not encryption.**

For production environments, Kubernetes Secrets should be combined with appropriate RBAC and encryption-at-rest controls. External secret-management systems can also be used.

---

# Task 3: Ingress

## Objective

The objective is to deploy an application, create a Service, configure an Ingress, and access the application through the Ingress.

The traffic flow is:

```text
Client
   |
   v
Ingress
   |
   v
Service
   |
   v
Pod
   |
   v
Application
```

## 1. Deploy Application

### `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: yatri-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: yatri-app
  template:
    metadata:
      labels:
        app: yatri-app
    spec:
      containers:
        - name: app
          image: nginx:alpine
          ports:
            - containerPort: 80
```

Apply:

```bash
kubectl apply -f deployment.yaml
```

Verify:

```bash
kubectl get deployment
kubectl get pods
```

The Deployment creates two application Pods.

---

## 2. Create Service

A Service provides a stable network endpoint for the Pods.

### `service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: yatri-app-service
spec:
  selector:
    app: yatri-app
  ports:
    - port: 80
      targetPort: 80
  type: ClusterIP
```

Apply:

```bash
kubectl apply -f service.yaml
```

Verify:

```bash
kubectl get service yatri-app-service
```

The Service forwards traffic to Pods having the label:

```text
app: yatri-app
```

---

## 3. Create Ingress

### `ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: yatri-app-ingress
spec:
  ingressClassName: nginx
  rules:
    - host: yatri.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: yatri-app-service
                port:
                  number: 80
```

Apply:

```bash
kubectl apply -f ingress.yaml
```

Verify:

```bash
kubectl get ingress
```

For detailed information:

```bash
kubectl describe ingress yatri-app-ingress
```

---

## 4. Access Application Through Ingress

The exact method depends on the Kubernetes environment and the installed Ingress Controller.

For a local environment, the hostname may need to be mapped in `/etc/hosts`:

```text
127.0.0.1 yatri.local
```

Then access:

```text
http://yatri.local
```

If the Ingress Controller provides an external IP, use that IP according to the controller's configuration.

Check the Ingress:

```bash
kubectl get ingress
```

---

## 5. Verify Ingress Routing

Use:

```bash
kubectl get ingress
kubectl describe ingress yatri-app-ingress
kubectl get service
kubectl get endpoints
kubectl get pods -o wide
```

The expected routing is:

```text
yatri.local
     |
     v
yatri-app-ingress
     |
     v
yatri-app-service
     |
     v
Yatri Application Pods
```

---

# Task 4: Ingress vs Ingress Controller

## What is Ingress?

Ingress is a Kubernetes API resource used to define rules for routing external HTTP and HTTPS traffic to services inside a Kubernetes cluster.

Ingress can define routing based on:

- Hostnames
- URL paths
- HTTP/HTTPS
- TLS

For example:

```text
yatri.local
     |
     v
yatri-app-service
     |
     v
Application Pods
```

The Ingress defines **where traffic should go**.

---

## What is an Ingress Controller?

An Ingress Controller is a software component that watches Kubernetes Ingress resources and implements the routing rules.

Examples include:

- NGINX Ingress Controller
- Traefik
- HAProxy
- Kong
- AWS Load Balancer Controller

The Ingress Controller actually receives and routes network traffic.

---

## Difference Between Ingress and Ingress Controller

| Ingress | Ingress Controller |
|---|---|
| Kubernetes API resource | Software component |
| Defines routing rules | Implements routing rules |
| Configuration object | Running controller |
| Does not route traffic by itself | Routes actual traffic |
| Usually written as YAML | Runs in the cluster |
| Example: `yatri-app-ingress` | Example: NGINX Ingress Controller |

### Simple Explanation

```text
Ingress
    =
Routing Rules

Ingress Controller
    =
Software that Implements the Rules
```

---

## Why Are Both Required?

An Ingress resource only describes the desired routing configuration.

It does not itself provide the software required to process network traffic.

The Ingress Controller reads the Ingress resource and implements those rules.

Therefore:

```text
                    Kubernetes Cluster
                           |
                    +------+------+
                    |             |
                 Ingress      Ingress Controller
                 Rules        Routing Software
                    |             |
                    +------+------+
                           |
                         Service
                           |
                           v
                          Pods
```

Both components work together to provide HTTP/HTTPS routing.

---

## Example

Suppose the Ingress contains:

```yaml
rules:
  - host: app.example.com
    http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: yatri-app-service
              port:
                number: 80
```

The Ingress defines the rule.

An NGINX Ingress Controller reads the rule and configures NGINX to route requests for:

```text
app.example.com
```

to:

```text
yatri-app-service
```

---

# Task 5: Troubleshooting

## Objective

The troubleshooting task demonstrates how to identify a Kubernetes problem, find its root cause, apply a fix, and verify the result.

## Step 1: Identify the Problem

Start by checking the cluster resources:

```bash
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get ingress
```

Look for problems such as:

```text
Pending
CrashLoopBackOff
ImagePullBackOff
ErrImagePull
```

---

## Step 2: Inspect the Pod

Run:

```bash
kubectl get pods -o wide
```

Then:

```bash
kubectl describe pod <pod-name>
```

Check the **Events** section for errors related to:

- Image pulling
- Scheduling
- Volume mounting
- Environment variables
- Probes
- Permissions

---

## Step 3: Check Logs

Run:

```bash
kubectl logs <pod-name>
```

If the container previously crashed:

```bash
kubectl logs <pod-name> --previous
```

Logs can reveal application startup errors and configuration problems.

---

## Step 4: Check the Service

Run:

```bash
kubectl get service
```

Then:

```bash
kubectl get endpoints
```

If a Service has no endpoints, check whether the Service selector matches the Pod labels.

For example, the Service may contain:

```yaml
selector:
  app: yatri-app
```

The Pods must contain:

```yaml
labels:
  app: yatri-app
```

---

## Step 5: Check Ingress

Run:

```bash
kubectl get ingress
```

Then:

```bash
kubectl describe ingress yatri-app-ingress
```

Check:

- Ingress class
- Hostname
- Path
- Service name
- Service port
- Backend endpoints

---

## Example Troubleshooting Problem

A common Ingress problem occurs when the Ingress references an incorrect Service name.

For example:

```yaml
backend:
  service:
    name: yatri-backend
```

But the actual Service is:

```text
yatri-app-service
```

Check the resources:

```bash
kubectl get ingress
kubectl describe ingress yatri-app-ingress
kubectl get service
kubectl get endpoints
```

The incorrect Service reference can then be identified.

### Fix

Change:

```yaml
name: yatri-backend
```

to:

```yaml
name: yatri-app-service
```

Apply the corrected configuration:

```bash
kubectl apply -f ingress.yaml
```

Verify:

```bash
kubectl describe ingress yatri-app-ingress
kubectl get endpoints yatri-app-service
```

Finally test the application:

```bash
curl http://yatri.local
```

---

# Useful Kubernetes Commands

## ConfigMap

```bash
kubectl apply -f app-config.yaml
kubectl get configmap
kubectl describe configmap yatri-app-config
```

## Secret

```bash
kubectl apply -f db-secret.yaml
kubectl get secret
kubectl describe secret yatri-db-secret
```

Decode a specific Secret value:

```bash
kubectl get secret yatri-db-secret \
  -o jsonpath='{.data.POSTGRES_PASSWORD}' | base64 --decode
```

## Pods

```bash
kubectl get pods
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

## Services

```bash
kubectl get services
kubectl describe service <service-name>
kubectl get endpoints
```

## Ingress

```bash
kubectl get ingress
kubectl describe ingress <ingress-name>
```

---

# Screenshots

## Screenshot 1: ConfigMap

The following screenshot demonstrates the creation and verification of the `yatri-app-config` ConfigMap.

![ConfigMap Screenshot](screenshots/01-configmap-demo.png)

The screenshot confirms:

```text
configmap/yatri-app-config created
```

and shows the five stored configuration values.

---

## Screenshot 2: Secret

The following screenshot demonstrates the creation and verification of the `yatri-db-secret` Secret.

![Secret Screenshot](screenshots/02-secret-demo.png)

The screenshot confirms:

```text
secret/yatri-db-secret created
```

and shows the command used to retrieve and decode the `POSTGRES_PASSWORD` value.

---

# Deliverables

The completed project contains the following components:

```text
session-12-ingress-configmaps-secrets/
│
├── 01-configmap/
│   ├── app-config.yaml
│   └── config-pod.yaml
│
├── 02-secret/
│   ├── db-secret.yaml
│   └── secret-pod.yaml
│
├── 03-ingress/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── troubleshooting/
│   ├── README.md
│   ├── broken configuration
│   └── fixed configuration
│
├── screenshots/
│   ├── 01-configmap-demo.png
│   └── 02-secret-demo.png
│
└── README.md
```

Additional screenshots should be added for the Ingress deployment and troubleshooting before final submission.

---

# Learning Outcomes

After completing this session, the following concepts have been demonstrated:

- Creating Kubernetes ConfigMaps.
- Storing application configuration using ConfigMaps.
- Injecting ConfigMap values into Pods.
- Creating Kubernetes Secrets.
- Storing sensitive values using Secrets.
- Injecting Secrets into containers.
- Understanding why credentials should not be committed to Git.
- Creating Kubernetes Deployments.
- Creating Kubernetes Services.
- Configuring Kubernetes Ingress.
- Understanding Ingress Controllers.
- Understanding the difference between Ingress and Ingress Controllers.
- Troubleshooting Kubernetes Pods, Services, and Ingress.
- Using `kubectl` commands to identify and resolve problems.

---

# Conclusion

This session demonstrates how Kubernetes can manage application configuration, sensitive information, and external application traffic.

**ConfigMaps** provide a way to separate normal application configuration from application code.

**Secrets** provide a Kubernetes mechanism for handling sensitive information such as database passwords and credentials.

**Services** provide stable network access to application Pods.

**Ingress** defines rules for routing HTTP and HTTPS traffic, while an **Ingress Controller** implements those routing rules.

The troubleshooting exercise demonstrates a systematic approach using commands such as `kubectl get`, `kubectl describe`, `kubectl logs`, and `kubectl get endpoints`.

Together, these concepts provide an important foundation for deploying and managing applications in Kubernetes.