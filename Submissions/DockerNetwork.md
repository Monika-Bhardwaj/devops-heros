# Docker Networking and Volumes Homework Solutions

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Docker Container Networking

We will create:
- `frontend` (Nginx) on network `front-net`
- `database` (MySQL) on network `db-net`
- `backend` (Nginx) attached to **two** networks: `back-net` and `front-net`

### Execution:

![alt text](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.32.02 PM.png>)
![Backend and Frontend Network Connectivity](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.33.19 PM.png>)

**Explanation:**  
`frontend` and `backend` are both on `front-net`, so they resolve each other’s names. `database` is isolated on `db-net`, so the other containers cannot reach it unless explicitly connected.

---

## Task 2: Host Network

![Host Network Apache on Port 80](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.38.18 PM.png>)

**Note** It did not work on macOS. 😭
You should see the default Apache “It works!” page.  
If port 80 is already used on your host, stop the conflicting service or use `sudo` if needed (on Linux, ports < 1024 require root, but Docker bypasses that if using host network? Actually, on Linux, binding to port 80 still requires root unless `net.ipv4.ip_unprivileged_port_start` is changed. If you get a permission error, run `sudo curl http://localhost` or use a non‑privileged port for the host network – but the task explicitly says port 80, so use `sudo` for the curl if needed).

---

## Task 3: Bind Mount

Create a local folder, write an `index.html`, and mount it into an Nginx container so that changes reflect immediately.

![alt text](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.40.27 PM.png>)

**Why?**  
Nginx reads the file from the filesystem on each request. The bind mount makes the host folder visible inside the container, so any change on the host is immediately seen by the container – no restart needed.

---


### Modify index.html and Verify Live Update:
```bash
echo "<h1>Hello students - Updated live without restarting container!</h1>" > html_mount/index.html
curl http://localhost:8081
```

![Bind Mount Live Update](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.41.01 PM.png>)

---

## Task 4: Overlay Network (Research & Explanation)

### What is a Docker Overlay Network?

An **overlay network** is a Docker network driver that enables **containers running on different Docker hosts** (physical or virtual machines) to communicate with each other as if they were on the same local network.

---

### Use Cases

- **Multi‑host microservices:** When you distribute a set of services across a swarm/cluster of machines.
- **Secure communication:** Overlay networks support encryption out‑of‑the‑box (using IPSec).
- **Load balancing:** Combined with Docker Swarm, overlay networks provide built‑in service discovery and load balancing.
- **Dynamic scaling:** Easily add/remove hosts without reconfiguring container IPs.

---

### How Overlay Networks Work Across Multiple Hosts

1. **Orchestration / Key‑Value Store**  
   Docker Swarm (or an external store like Consul) maintains a distributed key‑value store that tracks the state of the network (IP assignments, container locations).

2. **VXLAN Encapsulation**  
   Overlay networks use **VXLAN (Virtual Extensible LAN)** – a protocol that encapsulates Layer 2 Ethernet frames inside UDP packets (usually port 4789). This allows container traffic to be tunneled over an existing Layer 3 infrastructure (the host’s physical network).

3. **Gossip Protocol for Membership**  
   Swarm nodes run a gossip protocol (SWIM) to exchange information about container presence and health. This keeps the network state consistent across all hosts.

4. **Distributed Routing**  
   When Container A on Host 1 sends a packet to Container B on Host 2:
   - The network driver looks up the destination IP in the global store.
   - It determines that Container B resides on Host 2.
   - It encapsulates the packet in a VXLAN header, adds the outer IP (Host 2), and sends it over the physical network.
   - Host 2 decapsulates the packet and forwards it to Container B.

5. **Encryption (optional)**  
   You can enable the `--opt encrypted` flag, which uses IPSec to encrypt the VXLAN tunnel payload, ensuring data confidentiality across untrusted networks.

---

### Example Command to Create an Overlay Network (in Swarm mode)

```bash
# Initialize Swarm (if not already done)
docker swarm init

# Create an overlay network
docker network create -d overlay my-overlay

# Run a service on it (multiple replicas across hosts)
docker service create --network my-overlay --name web nginx:alpine
```
![alt text](<../Screenshots/Docker_Network/Screenshot 2026-09-02 at 7.49.28 PM.png>)
---
