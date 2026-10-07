# Session 13: Kubernetes Storage, HPA & Probes

## Overview

This session demonstrates important Kubernetes concepts related to **storage, autoscaling, and application health monitoring**.

The session covers:

- Kubernetes Volumes
- `emptyDir`
- `hostPath`
- PersistentVolume (PV)
- PersistentVolumeClaim (PVC)
- StorageClass
- Dynamic Provisioning
- Horizontal Pod Autoscaler (HPA)
- CPU-based autoscaling
- Kubernetes Metrics Server
- Load generation
- Liveness and Readiness Probes
- Monitoring and troubleshooting
- Mini-project implementation

---

# Task 1: Kubernetes Volumes

## Objective

The objective of this task is to understand how Kubernetes provides storage to containers and how different storage mechanisms are used depending on application requirements.

The following storage concepts are covered:

1. `emptyDir`
2. `hostPath`
3. PersistentVolume
4. PersistentVolumeClaim
5. StorageClass
6. Dynamic Provisioning

---

## 1. emptyDir

### What is emptyDir?

`emptyDir` is a temporary Kubernetes volume that is created when a Pod is assigned to a node.

The volume initially starts empty and can be used by one or more containers within the same Pod.

The data remains available as long as the Pod exists.

When the Pod is deleted, the `emptyDir` volume and its data are also deleted.

### Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-demo
spec:
  containers:
    - name: writer
      image: busybox
      command: ["sh", "-c", "echo 'Hello from emptyDir' > /data/message.txt; sleep 3600"]
      volumeMounts:
        - name: shared-storage
          mountPath: /data

    - name: reader
      image: busybox
      command: ["sh", "-c", "sleep 10; cat /data/message.txt; sleep 3600"]
      volumeMounts:
        - name: shared-storage
          mountPath: /data

  volumes:
    - name: shared-storage
      emptyDir: {}
```

Apply:

```bash
kubectl apply -f emptydir.yaml
```

Check the Pod:

```bash
kubectl get pods
```

Verify the file:

```bash
kubectl exec emptydir-demo -c reader -- cat /data/message.txt
```

Expected output:

```text
Hello from emptyDir
```

### Use Cases

`emptyDir` is useful for:

- Temporary files
- Scratch space
- Sharing files between containers in the same Pod
- Caching temporary data

### Limitation

Data is lost when the Pod is deleted.

---

# 2. hostPath

## What is hostPath?

`hostPath` mounts a directory or file from the Kubernetes node's filesystem into a Pod.

Example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-demo
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "echo 'HostPath example' > /data/message.txt; sleep 3600"]
      volumeMounts:
        - name: host-storage
          mountPath: /data

  volumes:
    - name: host-storage
      hostPath:
        path: /tmp/kubernetes-data
        type: DirectoryOrCreate
```

Apply:

```bash
kubectl apply -f hostpath.yaml
```

Verify:

```bash
kubectl exec hostpath-demo -- cat /data/message.txt
```

### Advantages

- Provides access to node-level storage.
- Simple to configure.
- Useful for some node-level applications.

### Disadvantages

- Ties the Pod to the node's filesystem.
- Not suitable for most production applications.
- Data may not be available if the Pod moves to another node.
- Can create security risks if used incorrectly.

---

# 3. PersistentVolume

## What is a PersistentVolume?

A **PersistentVolume (PV)** is a piece of storage in the Kubernetes cluster that has been provisioned for use by applications.

Unlike `emptyDir`, a PersistentVolume is designed for persistent application data.

Example:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: demo-pv
spec:
  capacity:
    storage: 1Gi

  accessModes:
    - ReadWriteOnce

  persistentVolumeReclaimPolicy: Retain

  hostPath:
    path: /mnt/data/demo
```

Check the PV:

```bash
kubectl get pv
```

Detailed information:

```bash
kubectl describe pv demo-pv
```

### Important PV Properties

A PV can define:

- Storage capacity
- Access modes
- Reclaim policy
- Storage backend
- Storage class

---

# 4. PersistentVolumeClaim

## What is a PersistentVolumeClaim?

A **PersistentVolumeClaim (PVC)** is a request for storage made by a Kubernetes application.

Instead of directly configuring a Pod with a storage implementation, the application requests storage through a PVC.

Example:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-pvc
spec:
  accessModes:
    - ReadWriteOnce

  resources:
    requests:
      storage: 500Mi
```

Apply:

```bash
kubectl apply -f pvc.yaml
```

Check:

```bash
kubectl get pvc
```

Expected status:

```text
NAME       STATUS   VOLUME
demo-pvc   Bound    demo-pv
```

The PVC becomes associated with a suitable PersistentVolume.

---

# 5. Using PVC in a Pod

A Pod can mount the PVC as follows:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pvc-demo
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "echo 'Persistent data' > /data/message.txt; sleep 3600"]

      volumeMounts:
        - name: persistent-storage
          mountPath: /data

  volumes:
    - name: persistent-storage
      persistentVolumeClaim:
        claimName: demo-pvc
```

Apply:

```bash
kubectl apply -f pvc-pod.yaml
```

Verify:

```bash
kubectl exec pvc-demo -- cat /data/message.txt
```

Expected output:

```text
Persistent data
```

---

# 6. StorageClass

## What is a StorageClass?

A **StorageClass** defines different types or classes of storage that can be requested by applications.

It allows administrators to describe the storage characteristics available in a Kubernetes cluster.

Examples of storage characteristics include:

- Performance
- Provisioning method
- Replication
- Storage backend
- Reclaim behavior

Check available StorageClasses:

```bash
kubectl get storageclass
```

or:

```bash
kubectl get sc
```

Detailed information:

```bash
kubectl describe storageclass <storage-class-name>
```

---

# 7. Dynamic Provisioning

## What is Dynamic Provisioning?

Dynamic provisioning allows Kubernetes to automatically create storage when an application creates a PVC.

Without dynamic provisioning:

```text
Administrator
      |
      v
Create PV
      |
      v
Application creates PVC
      |
      v
PVC binds to PV
```

With dynamic provisioning:

```text
Application
     |
     v
Creates PVC
     |
     v
StorageClass
     |
     v
Provisioner
     |
     v
Storage Automatically Created
```

Example PVC:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
spec:
  accessModes:
    - ReadWriteOnce

  storageClassName: standard

  resources:
    requests:
      storage: 1Gi
```

Apply:

```bash
kubectl apply -f dynamic-pvc.yaml
```

Check:

```bash
kubectl get pvc
```

Then:

```bash
kubectl get pv
```

The Kubernetes storage provisioner automatically creates the required PersistentVolume.

---

# Storage Comparison

| Storage Type | Persistent | Main Use |
|---|---|---|
| `emptyDir` | No | Temporary Pod storage |
| `hostPath` | Potentially | Node-level storage |
| PersistentVolume | Yes | Persistent application storage |
| PVC | Yes | Application storage request |
| StorageClass | Depends | Defines storage types |
| Dynamic Provisioning | Yes | Automatically creates storage |

---

# Task 2: HPA Hands-on

## Objective

The objective of this task is to configure a Horizontal Pod Autoscaler and observe Kubernetes automatically increase or decrease the number of Pods based on CPU utilization.

HPA stands for:

**Horizontal Pod Autoscaler**

It automatically changes the number of Pod replicas according to resource utilization or other supported metrics.

---

# 1. Prerequisites for HPA

HPA CPU-based scaling requires resource requests to be defined for the application container.

Example:

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"

  limits:
    cpu: "500m"
    memory: "256Mi"
```

The Kubernetes Metrics Server should also be available.

Check:

```bash
kubectl get deployment metrics-server -n kube-system
```

Check metrics:

```bash
kubectl top pods
```

If metrics are available, the cluster is ready for CPU-based HPA testing.

---

# 2. Deploy the Application

The application can be deployed using the provided `hpa.yml`.

Example:

```bash
kubectl apply -f hpa.yml
```

Verify:

```bash
kubectl get deployments
```

Then:

```bash
kubectl get pods
```

---

# 3. Configure HPA

Example HPA configuration:

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: yatri-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: yatri-app

  minReplicas: 2
  maxReplicas: 10

  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```

Apply:

```bash
kubectl apply -f hpa.yml
```

---

# 4. Verify HPA

Run:

```bash
kubectl get hpa
```

Example:

```text
NAME        REFERENCE              TARGETS   MINPODS   MAXPODS   REPLICAS
yatri-hpa   Deployment/yatri-app   5%/50%    2         10        2
```

The important fields are:

- **TARGETS** - Current CPU usage compared with target.
- **MINPODS** - Minimum number of Pods.
- **MAXPODS** - Maximum number of Pods.
- **REPLICAS** - Current number of replicas.

---

# 5. Describe HPA

Run:

```bash
kubectl describe hpa yatri-hpa
```

This displays:

- Current CPU utilization
- Target CPU utilization
- Minimum replicas
- Maximum replicas
- Current replicas
- Scaling events
- Conditions

---

# 6. Check Pod CPU Usage

Run:

```bash
kubectl top pods
```

Example:

```text
NAME                          CPU(cores)   MEMORY(bytes)
yatri-app-xxxxxxxxxx-abcde    20m          15Mi
yatri-app-xxxxxxxxxx-fghij    18m          14Mi
```

This command displays the current resource usage of Pods.

---

# 7. Deploy Load Generator

A temporary load-generator Pod can be used to generate CPU load.

Example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: load-generator
spec:
  containers:
    - name: load-generator
      image: busybox
      command:
        - /bin/sh
        - -c
        - |
          while true; do
            wget -q -O- http://yatri-app-service;
          done
```

Apply:

```bash
kubectl apply -f load-generator.yaml
```

Verify:

```bash
kubectl get pod load-generator
```

---

# 8. Increase Application Load

Once the load generator is running, it continuously sends requests to the application.

Check CPU usage:

```bash
kubectl top pods
```

Check HPA:

```bash
kubectl get hpa
```

At first, the application may have only the minimum number of replicas:

```text
REPLICAS
2
```

As CPU utilization increases above the configured target, the HPA may increase the number of Pods.

For example:

```text
2 → 3 → 4 → 5
```

The exact number and timing depend on the cluster and workload.

---

# 9. Observe Pod Scaling

Continuously monitor the Pods:

```bash
kubectl get pods -w
```

Also monitor the HPA:

```bash
kubectl get hpa -w
```

Check CPU:

```bash
kubectl top pods
```

The expected behavior is:

```text
Low CPU
   |
   v
2 Pods
   |
   | Increased Load
   v
High CPU
   |
   v
HPA Detects High Utilization
   |
   v
More Pods Created
   |
   v
CPU Load Distributed
```

---

# 10. Example HPA Output

Example:

```text
$ kubectl get hpa

NAME        REFERENCE              TARGETS    MINPODS   MAXPODS   REPLICAS
yatri-hpa   Deployment/yatri-app   82%/50%    2         10        5
```

This indicates that the observed CPU utilization is higher than the target, so the HPA has increased the number of replicas.

After the load decreases, the HPA can reduce the number of replicas toward the configured minimum.

---

# HPA Commands Summary

### Get HPA

```bash
kubectl get hpa
```

### Describe HPA

```bash
kubectl describe hpa yatri-hpa
```

### Get Pods

```bash
kubectl get pods
```

### Monitor Pods

```bash
kubectl get pods -w
```

### View Resource Usage

```bash
kubectl top pods
```

### View Deployment

```bash
kubectl get deployment
```

### Monitor HPA

```bash
kubectl get hpa -w
```

---

# HPA Troubleshooting

If HPA does not scale, check the following.

## Check Metrics Server

```bash
kubectl get pods -n kube-system
```

Look for:

```text
metrics-server
```

Then:

```bash
kubectl top pods
```

If `kubectl top pods` does not return metrics, the Metrics Server may not be functioning correctly.

## Check Resource Requests

The Deployment should contain:

```yaml
resources:
  requests:
    cpu: "100m"
```

Without an appropriate CPU request, CPU utilization based HPA may not behave as expected.

## Describe HPA

```bash
kubectl describe hpa yatri-hpa
```

Check the **Conditions** and **Events** sections.

---

# Screenshots and Output

The following screenshots should be captured during the hands-on exercise.

## Screenshot 1: HPA

Capture:

```bash
kubectl get hpa
```

The screenshot should show:

- HPA name
- CPU target
- Minimum replicas
- Maximum replicas
- Current replicas

Example:

```text
NAME        REFERENCE              TARGETS    MINPODS   MAXPODS   REPLICAS
yatri-hpa   Deployment/yatri-app   82%/50%    2         10        5
```

---

## Screenshot 2: Pod Scaling

Capture:

```bash
kubectl get pods
```

before and after the load is generated.

### Before Load

```text
NAME                          READY
yatri-app-xxxxx               1/1
yatri-app-yyyyy               1/1
```

### During High Load

```text
NAME                          READY
yatri-app-xxxxx               1/1
yatri-app-yyyyy               1/1
yatri-app-zzzzz               1/1
yatri-app-aaaaa               1/1
yatri-app-bbbbb               1/1
```

This demonstrates horizontal scaling.

---

## Screenshot 3: CPU Utilization

Capture:

```bash
kubectl top pods
```

The output should demonstrate increased CPU consumption during the load test.

---

## Screenshot 4: HPA Description

Capture:

```bash
kubectl describe hpa yatri-hpa
```

The screenshot should show the HPA's scaling conditions and events.

---

# Task 3: Kubernetes Probes

## What are Kubernetes Probes?

Kubernetes probes allow the platform to determine the health and availability of application containers.

There are three main types:

1. Liveness Probe
2. Readiness Probe
3. Startup Probe

---

# 1. Liveness Probe

A liveness probe determines whether a container is still functioning correctly.

If the liveness probe repeatedly fails, Kubernetes can restart the container.

Example:

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 10
```

---

# 2. Readiness Probe

A readiness probe determines whether a container is ready to receive traffic.

If the readiness probe fails, Kubernetes removes the Pod from the Service's available endpoints.

Example:

```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
```

---

# 3. Startup Probe

A startup probe is useful for applications that take a long time to start.

Example:

```yaml
startupProbe:
  httpGet:
    path: /
    port: 80
  failureThreshold: 30
  periodSeconds: 10
```

The startup probe gives the application additional time to initialize before liveness checking becomes active.

---

# Liveness vs Readiness

| Liveness Probe | Readiness Probe |
|---|---|
| Checks whether the container is alive | Checks whether the container is ready |
| Failure may cause container restart | Failure removes Pod from Service endpoints |
| Detects broken applications | Controls traffic routing |
| Maintains application health | Maintains application availability |

---

# Example Application with Probes

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
        - name: yatri-app
          image: nginx:alpine
          ports:
            - containerPort: 80

          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"

            limits:
              cpu: "500m"
              memory: "256Mi"

          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 10

          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
```

---

# Mini Project

## Objective

The Session 13 mini project combines Kubernetes storage, autoscaling, and application health monitoring into a single application deployment.

The application should demonstrate:

- Persistent storage
- Deployment
- Service
- HPA
- Resource requests and limits
- Liveness probe
- Readiness probe
- Load generation
- Monitoring

A suggested architecture is:

```text
                         Kubernetes Cluster
                                |
                 +--------------+--------------+
                 |                             |
                 v                             v
             HPA                            Service
                 |                             |
                 v                             v
        +----------------+              +-------------+
        | Application    |              | Application |
        | Pod 1          |              | Service     |
        +----------------+              +-------------+
                 |
        +----------------+
        | Application    |
        | Pod 2          |
        +----------------+
                 |
        +----------------+
        | PVC            |
        +----------------+
                 |
        +----------------+
        | Persistent     |
        | Storage       |
        +----------------+

             Load Generator
                    |
                    v
              Application
```

---

# Mini Project Verification

Check all resources:

```bash
kubectl get all
```

Check storage:

```bash
kubectl get pv
kubectl get pvc
```

Check HPA:

```bash
kubectl get hpa
```

Check CPU:

```bash
kubectl top pods
```

Check application health:

```bash
kubectl describe pod <pod-name>
```

Check probe status:

```bash
kubectl get pods
```

Check Service:

```bash
kubectl get service
```

---

# Suggested Project Structure

```text
session-13-kubernetes-storage-hpa/
│
├── 01-kubernetes-volumes/
│   ├── README.md
│   ├── emptydir.yaml
│   ├── hostpath.yaml
│   ├── pv.yaml
│   ├── pvc.yaml
│   └── storageclass.yaml
│
├── 02-hpa/
│   ├── hpa.yml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── load-generator.yaml
│
├── 03-probes/
│   └── deployment-with-probes.yaml
│
├── 04-mini-project/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── pvc.yaml
│   ├── hpa.yaml
│   └── load-generator.yaml
│
├── screenshots/
│   ├── hpa-output.png
│   ├── pod-scaling.png
│   ├── cpu-utilization.png
│   └── hpa-description.png
│
└── README.md
```

---

# Deliverables

The completed Session 13 project should contain:

- [x] Volume documentation
- [x] `emptyDir` example
- [x] `hostPath` example
- [x] PersistentVolume documentation
- [x] PersistentVolumeClaim documentation
- [x] StorageClass documentation
- [x] Dynamic provisioning explanation
- [x] HPA YAML
- [x] Load generator
- [x] HPA output
- [x] CPU utilization output
- [x] Pod scaling output
- [x] Liveness probe
- [x] Readiness probe
- [x] Mini-project implementation
- [x] Screenshots
- [x] README documentation

---

# Learning Outcomes

After completing this session, the following concepts are understood:

1. Kubernetes temporary and persistent storage.
2. Difference between `emptyDir` and `hostPath`.
3. PersistentVolumes and PersistentVolumeClaims.
4. StorageClasses.
5. Dynamic storage provisioning.
6. Kubernetes resource requests and limits.
7. Horizontal Pod Autoscaling.
8. CPU-based autoscaling.
9. Metrics Server and `kubectl top`.
10. Load generation and performance testing.
11. Liveness probes.
12. Readiness probes.
13. Startup probes.
14. Kubernetes health monitoring.
15. Troubleshooting autoscaling and application health.

---

# Conclusion

Session 13 demonstrates how Kubernetes applications can be made more **persistent, scalable, and reliable**.

Kubernetes storage mechanisms allow applications to work with both temporary and persistent data. PersistentVolumes and PersistentVolumeClaims provide a standardized way to request and consume persistent storage, while StorageClasses and dynamic provisioning simplify storage management.

The Horizontal Pod Autoscaler automatically adjusts the number of application Pods according to resource utilization. By generating additional traffic and monitoring CPU usage with `kubectl top pods`, the scaling behavior can be observed directly.

Kubernetes probes provide another important layer of reliability. Liveness probes help detect unhealthy containers, while readiness probes ensure that traffic is only sent to application instances that are ready to serve requests.

Together, **storage, HPA, and probes** provide important building blocks for deploying reliable and scalable applications in Kubernetes.