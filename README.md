# DevOps Heroes – Comprehensive Homework & Lab Submissions

### Student Information
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Roll / Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 LTS (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Kernel 7.0 |
| **GitHub Repository** | [https://github.com/Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## 📋 Section A: DevOps Homework Submission Links

Direct links to the `README.md` files for submission in the Google Form:

| # | Homework Module | Submission GitHub Link | Alternate / Submissions Path |
|---|---|---|---|
| 1 | **Docker Images** | [session6-7-docker/multi-stage-dockerfile/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session6-7-docker/multi-stage-dockerfile/README.md) | [Submissions/Docker_Images/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Docker_Images/README.md) |
| 2 | **Docker Networking** | [session8-docker-networking-volume/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session8-docker-networking-volume/README.md) | [Submissions/Docker_Networking/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Docker_Networking/README.md) |
| 3 | **Linux Fundamentals** | [session2-linux/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session2-linux/README.md) | [Submissions/Linux_Fundamentals/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Linux_Fundamentals/README.md) |
| 4 | **Networking** | [session4-networking/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session4-networking/README.md) | [Submissions/Networking/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Networking/README.md) |
| 5 | **Git and GitHub** | [session5-git-github/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session5-git-github/README.md) | [Submissions/Git_GitHub/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Git_GitHub/README.md) |
| 6 | **Docker Fundamentals** | [session6-7-docker/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session6-7-docker/README.md) | [Submissions/Docker_Fundamentals/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Docker_Fundamentals/README.md) |
| 7 | **Shell Scripting** | [session3-shell-scripting/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/session3-shell-scripting/README.md) | [Submissions/Shell_Scripting/README.md](https://github.com/Monika-Bhardwaj/devops-heros/blob/main/Submissions/Shell_Scripting/README.md) |

---

## 🗂️ Module Summaries & Overview

### 1. Linux Fundamentals
- **Folder**: [`session2-linux/`](session2-linux/)
- **Documentation**: [`session2-linux/README.md`](session2-linux/README.md)
- **Key Deliverables**:
  - **Task 1: Soft Link vs Hard Link**: Inode comparison, creation (`ln -s` vs `ln`), deletion behavior, interview questions and answers.
  - **Task 2: `adduser` vs `useradd`**: Differences, why `adduser` is preferred on Ubuntu/Debian, test user creation and lifecycle.
  - **Task 3: `journalctl`**: Systemd journal exploration, viewing boot logs (`-b`), following logs live (`-f`), and filtering logs by specific unit/service (`-u`).
  - **Task 4: Linux Command Cheat Sheet**: Complete reference table with commands, syntax, and purpose.

---

### 2. Shell Scripting
- **Folder**: [`session3-shell-scripting/`](session3-shell-scripting/)
- **Script**: [`session3-shell-scripting/system_info.sh`](session3-shell-scripting/system_info.sh)
- **Documentation**: [`session3-shell-scripting/README.md`](session3-shell-scripting/README.md)
- **Key Deliverables**:
  - Script printing date (`date`), hostname (`hostname`), current user (`whoami`), disk usage (`df -h`), and running processes (`ps aux`).
  - Storing system data in shell variables.
  - Interactive user prompt using `read -p`.
  - Creating directory with `mkdir -p` and file with `touch`.
  - Storing running processes in file using `>` output redirection.
  - Full execution output and verified logs saved in `monika_sysinfo/processes.txt`.

---

### 3. Networking Fundamentals
- **Folder**: [`session4-networking/`](session4-networking/)
- **Documentation**: [`session4-networking/README.md`](session4-networking/README.md)
- **Key Deliverables**:
  - Diagnostic utilities executed live on host: `ping`, `ip addr`, `ip route`, `ss -tuln`, `hostname`, `dig`, `curl -I`, `tracepath`.
  - Output analysis and explanation for each command.
  - Subnetting, OSI reference model, and DNS resolution breakdown.

---

### 4. Git and GitHub
- **Folder**: [`session5-git-github/`](session5-git-github/)
- **Documentation**: [`session5-git-github/README.md`](session5-git-github/README.md)
- **Key Deliverables**:
  - **Task 1: `git commit -a -m` vs `git commit -m`**: Practical test comparing staged commits vs automatically staged tracked file commits.
  - **Task 2: Git Cherry-Pick**: Creating branch commits, inspecting commit history with `git log --oneline`, cherry-picking specific commit to `main`, and verifying changes.

---

### 5. Docker Fundamentals
- **Folder**: [`session6-7-docker/`](session6-7-docker/)
- **Documentation**: [`session6-7-docker/README.md`](session6-7-docker/README.md)
- **6 Hello-World Applications Deployed**:
  1. `nodejs-app` (Express HTTP server on port 3000)
  2. `python-app` (Flask HTTP server on port 5000)
  3. `java-app` (Java HTTP server on port 8080)
  4. `Apache-app` (Apache HTTP server on port 80/8081)
  5. `React-app` (React app on port 3001)
  6. `nginx-app` (Nginx HTTP server on port 80/8082)
- Each contains source code, `Dockerfile`, build instructions, and webpage verification screenshots.

---

### 6. Dockerfiles & Images (Multi-Stage Build)
- **Folder**: [`session6-7-docker/multi-stage-dockerfile/`](session6-7-docker/multi-stage-dockerfile/)
- **Documentation**: [`session6-7-docker/multi-stage-dockerfile/README.md`](session6-7-docker/multi-stage-dockerfile/README.md)
- **Key Deliverables**:
  - Multi-stage build theory and optimization.
  - Builder stage (`node:24-alpine`) and lean production stage.
  - Running on port 8080: `docker run -p 8080:3000 multi-stage-hello`.
  - Verifying: `Hello World from Docker multi-stage build`.
  - Verifying running container with `docker ps`.
  - Deployment overview across Node.js, Python, and Java.

---

### 7. Docker Networking & Volumes
- **Folder**: [`session8-docker-networking-volume/`](session8-docker-networking-volume/)
- **Documentation**: [`session8-docker-networking-volume/README.md`](session8-docker-networking-volume/README.md)
- **Key Deliverables**:
  - **Task 1: Container Networking**: 3 containers (`frontend`, `backend`, `database`), 3 bridge networks (`front-net`, `back-net`, `db-net`), dual-homed backend, inter-container connectivity and isolation.
  - **Task 2: Host Network**: Apache container on host network bound to port 80.
  - **Task 3: Bind Mount**: Host directory mounted to Nginx container; dynamic editing of `index.html` verified live without container restart.
  - **Task 4: Overlay Networks**: Multi-host Docker Swarm architecture, VXLAN encapsulation (UDP 4789), distributed key-value store, and security encryption.

---

## 🛠️ Technology Stack
- **OS**: Ubuntu Linux 24.04 LTS (Kernel 7.0)
- **Host**: ASUS Laptop (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`)
- **Shell**: GNU Bash
- **Version Control**: Git & GitHub
- **Containerization**: Docker Desktop Engine
- **Web Servers & Runtimes**: Nginx, Apache HTTP Server, Node.js (Express), Python (Flask), Java (OpenJDK)
