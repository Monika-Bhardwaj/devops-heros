# Docker Networking and Volumes Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Docker Desktop Engine |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Docker Container Networking

### Architecture Implemented
- **3 User-Defined Bridge Networks**:
  - `front-net`: Interconnects frontend and backend services.
  - `back-net`: Internal backend application network.
  - `db-net`: Isolated database network.
- **3 Containers**:
  - `frontend-c` (Nginx): Connected to `front-net`.
  - `backend-c` (Nginx): Dual-homed, connected to both `front-net` and `back-net`.
  - `database-c` (MySQL/Alpine): Connected strictly to `db-net`.

### Commands Executed & Output Observed
```bash
# 1. Create networks
docker network create front-net
docker network create back-net
docker network create db-net

# 2. Start containers
docker run -d --name frontend-c --network front-net nginx:alpine
docker run -d --name backend-c --network back-net nginx:alpine
docker network connect front-net backend-c
docker run -d --name database-c --network db-net alpine sleep 3600

# 3. Test connectivity between frontend and backend
docker exec frontend-c ping -c 2 backend-c
```
**Output**:
```text
PING backend-c (172.23.0.3): 56 data bytes
64 bytes from 172.23.0.3: seq=0 ttl=64 time=0.403 ms
64 bytes from 172.23.0.3: seq=1 ttl=64 time=0.152 ms
--- backend-c ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
```

```bash
# 4. Test isolation against database
docker exec frontend-c ping -c 2 database-c
```
**Output**:
```text
ping: bad address 'database-c'
```
*(Confirms that `database-c` is completely isolated on `db-net` and cannot be reached or resolved by `frontend-c`)*.

### Screenshot Evidence: Container Networking & Isolation
![Container Networking Verification](<../../Screenshots/Docker_Network/docker_container_networking.png>)

---

## Task 2: Host Network

### Concept
When using `--network host`, the container shares the host machine's networking namespace directly. It bypasses Docker's virtual bridge and port forwarding NAT, binding directly to the host's network interfaces.

### Command Executed
```bash
docker run -d --network host --name apache-host-app httpd:2.4-alpine
curl http://localhost:80
```
**Observed Result**:
The Apache web server binds directly to port 80 on the host interface. Any HTTP request to `http://localhost:80` is handled directly by Apache with near-zero network translation latency.

---

## Task 3: Bind Mount

### Concept
A **bind mount** maps an exact directory or file path from the host machine directly into the container filesystem (`-v /host/path:/container/path`). Unlike container image layers, file modifications made on the host filesystem are immediately visible inside the running container without rebuilding or restarting.

### Practical Live Verification
1. **Created initial `index.html` on host**:
   ```bash
   echo "<h1>Hello students</h1>" > docker_bind_mount/index.html
   ```
2. **Ran container with bind mount on port 8085**:
   ```bash
   docker run -d -p 8085:80 -v $(pwd)/docker_bind_mount:/usr/share/nginx/html:ro --name nginx-bind-mount nginx:alpine
   ```
3. **Accessed website**:
   ```bash
   curl http://localhost:8085
   # Output: <h1>Hello students</h1>
   ```
4. **Modified `index.html` on host without restarting container**:
   ```bash
   echo "<h1>Hello students - Live update on Monika ASUS Laptop without restarting container!</h1>" > docker_bind_mount/index.html
   ```
5. **Re-accessed website**:
   ```bash
   curl http://localhost:8085
   # Output: <h1>Hello students - Live update on Monika ASUS Laptop without restarting container!</h1>
   ```
   **Verification Result**: Immediate reflection of changes confirmed without container restart!

### Screenshot Evidence: Bind Mount Live Update
![Bind Mount Live Update](<../../Screenshots/Docker_Network/docker_bind_mount_live_update.png>)

---

## Task 4: Docker Overlay Network (Research & Architecture)

### What is an Overlay Network?
A **Docker overlay network** is a multi-host software-defined network driver that allows containers distributed across distinct physical or virtual machines (Docker Swarm nodes) to communicate securely as if they were co-located on a single local Layer 2 broadcast domain.

### Key Use Cases
1. **Multi-Host Microservices**: Orchestrating scalable services distributed across multiple cloud VMs or bare-metal servers.
2. **Encrypted Inter-Service Traffic**: Automatic payload encryption using IPSec with AES-GCM algorithms (`--opt encrypted`).
3. **Built-in Service Discovery & Routing Mesh**: Resolving service names via embedded DNS and load-balancing traffic across container replicas.

### How Overlay Networks Function Across Multiple Hosts
1. **Control Plane (Swarm & Gossip Protocol)**:
   - Swarm manager nodes maintain a distributed Raft-based consensus store tracking service replicas and VIPs (Virtual IPs).
   - Worker nodes participate in a decentralized SWIM gossip protocol to synchronize membership and container state.
2. **Data Plane (VXLAN Encapsulation)**:
   - Overlay traffic utilizes **VXLAN (Virtual Extensible LAN)**, defined in RFC 7348.
   - Standard Ethernet frames from a container are encapsulated into outer UDP datagrams destined for UDP port **4789**.
   - The destination host receives the UDP packet, strips the outer IP/UDP/VXLAN headers, and delivers the original Layer 2 frame to the destination container.
3. **Routing Mesh (Ingress Network)**:
   - An ingress overlay network routes external client connections arriving on any Swarm node to active service replicas on any node in the cluster.
