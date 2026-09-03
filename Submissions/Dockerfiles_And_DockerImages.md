# Docker Multi-Stage Build & Images Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Docker Desktop Engine |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Run Multi-Stage Dockerfile

### What is a Multi-Stage Build?
A **multi-stage build** is a Docker optimization technique where multiple `FROM` instructions are defined within a single `Dockerfile`. Each stage can use a distinct base image and selectively copy only the compiled artifacts and production dependencies from earlier stages.
- **Benefits**:
  - Eliminates build tools, compilers, development dependencies, and package managers from the final image.
  - Substantially decreases image attack surface and vulnerability count.
  - Drastically shrinks final image size for faster network pulls and deployments.

### Multi-Stage Dockerfile Analysis
```dockerfile
# -------------------------
# Stage 1: Build Stage
# -------------------------
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# -------------------------
# Stage 2: Production Stage
# -------------------------
FROM node:24-alpine AS production
WORKDIR /app
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/server.js ./
EXPOSE 3000
CMD ["npm", "start"]
```

### Execution & Verification on Monika's Laptop
1. **Built image using multi-stage Dockerfile**:
   ```bash
   docker build -t multi-stage-hello session6-7-docker/multi-stage-dockerfile
   ```
2. **Ran container on port 8080**:
   ```bash
   docker run -d -p 8080:3000 --name multistage-monika multi-stage-hello
   ```
3. **Accessed application on port 8080**:
   ```bash
   curl http://localhost:8080
   ```
   **Observed Web Output**:
   ```html
   <h1>Hello World from Docker Multi-Stage Build!</h1>
   ```
4. **Verified running container using `docker ps` on port 8080**:
   ```text
   CONTAINER ID   IMAGE               COMMAND                  STATUS         PORTS                                         NAMES
   536017d3a854   multi-stage-hello   "docker-entrypoint.s…"   Up 2 seconds   0.0.0.0:8080->3000/tcp, [::]:8080->3000/tcp   multistage-monika
   ```

---

## Task 2: Documentation & Screenshots

### Terminal Evidence: Build, Curl, and `docker ps` Output
![Multi-Stage Build and docker ps](<../Screenshots/DockerFiles_Images/multistage_build_and_ps.png>)

### Browser Evidence: Web Output on Port 8080
![Multi-Stage Web Browser Output](<../Screenshots/DockerFiles_Images/multistage_browser_output.png>)

---

## Task 3: Docker Application Deployment (3 Application Types)

Deployed 3 different types of applications using Docker on Monika's laptop:

### 1. Node.js Application
- **Directory**: `session6-7-docker/nodejs-app/`
- **Framework**: Express.js HTTP Server
- **Port Mapping**: `3000:3000`
- **Output**: `Hello World from Node.js!`
- **Command**: `docker run -d -p 3000:3000 nodejs-hello`

### 2. Python Application
- **Directory**: `session6-7-docker/python-app/`
- **Framework**: Flask Web Application
- **Port Mapping**: `5000:5000`
- **Output**: `Hello World from Python!`
- **Command**: `docker run -d -p 5000:5000 python-hello`

### 3. Java Application
- **Directory**: `session6-7-docker/java-app/`
- **Technology**: Java HTTP Server (`HttpServer`)
- **Port Mapping**: `8080:8080`
- **Output**: `Hello World from Java!`
- **Command**: `docker run -d -p 8080:8080 java-hello`
