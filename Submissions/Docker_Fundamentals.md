# Docker Fundamentals Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Docker Desktop Engine |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task: Hello World Applications in Docker

Created standalone containerized web applications for 6 distinct technologies, each in its own dedicated directory containing application code, dependencies, and `Dockerfile`:
- `nodejs-app`
- `python-app`
- `java-app`
- `Apache-app`
- `React-app`
- `nginx-app`

---

## Application Directory Structure

```text
session6-7-docker/
├── nodejs-app/
│   ├── package.json
│   ├── index.js
│   └── Dockerfile
├── python-app/
│   ├── requirements.txt
│   ├── app.py
│   └── Dockerfile
├── java-app/
│   ├── HelloWorld.java
│   └── Dockerfile
├── Apache-app/
│   ├── index.html
│   └── Dockerfile
├── React-app/
│   ├── package.json
│   ├── public/
│   ├── src/
│   └── Dockerfile
└── nginx-app/
    ├── index.html
    └── Dockerfile
```

---

## Detailed Application Breakdown & Verification

### 1. Node.js Application (`nodejs-app`)
- **Base Image**: `node:18-alpine`
- **Framework**: Express.js
- **Container Port**: `3000` | **Host Port**: `3000`
- **Build & Run**:
  ```bash
  docker build -t nodejs-hello session6-7-docker/nodejs-app
  docker run -d -p 3000:3000 --name nodejs-app-monika nodejs-hello
  ```
- **Web Output Verification**:
  ```bash
  curl http://localhost:3000
  # Output: Hello World from Node.js!
  ```
- **Browser Screenshot**:
  ![Node.js Web Output](<../Screenshots/Docker_Fundamentals/nodejs_browser.png>)

---

### 2. Python Application (`python-app`)
- **Base Image**: `python:3.11-alpine`
- **Framework**: Flask
- **Container Port**: `5000` | **Host Port**: `5000`
- **Build & Run**:
  ```bash
  docker build -t python-hello session6-7-docker/python-app
  docker run -d -p 5000:5000 --name python-app-monika python-hello
  ```
- **Web Output Verification**:
  ```bash
  curl http://localhost:5000
  # Output: Hello World from Python!
  ```
- **Browser Screenshot**:
  ![Python Web Output](<../Screenshots/Docker_Fundamentals/python_browser.png>)

---

### 3. Java Application (`java-app`)
- **Base Image**: `eclipse-temurin:17-jdk`
- **Technology**: Java built-in `com.sun.net.httpserver.HttpServer`
- **Container Port**: `8080` | **Host Port**: `8080`
- **Build & Run**:
  ```bash
  docker build -t java-hello session6-7-docker/java-app
  docker run -d -p 8080:8080 --name java-app-monika java-hello
  ```
- **Web Output Verification**:
  ```bash
  curl http://localhost:8080
  # Output: Hello World from Java!
  ```
- **Browser Screenshot**:
  ![Java Web Output](<../Screenshots/Docker_Fundamentals/java_browser.png>)

---

### 4. Apache Web Server (`Apache-app`)
- **Base Image**: `httpd:2.4-alpine`
- **Content**: Custom `index.html`
- **Container Port**: `80` | **Host Port**: `8081`
- **Build & Run**:
  ```bash
  docker build -t apache-hello session6-7-docker/Apache-app
  docker run -d -p 8081:80 --name apache-app-monika apache-hello
  ```
- **Web Output Verification**:
  ```bash
  curl http://localhost:8081
  # Output: <h1>Hello World from Apache!</h1>
  ```
- **Browser Screenshot**:
  ![Apache Web Output](<../Screenshots/Docker_Fundamentals/apache_browser.png>)

---

### 5. Nginx Web Server (`nginx-app`)
- **Base Image**: `nginx:alpine`
- **Content**: Custom `index.html`
- **Container Port**: `80` | **Host Port**: `8082`
- **Build & Run**:
  ```bash
  docker build -t nginx-hello session6-7-docker/nginx-app
  docker run -d -p 8082:80 --name nginx-app-monika nginx-hello
  ```
- **Web Output Verification**:
  ```bash
  curl http://localhost:8082
  # Output: <h1>Hello World from Nginx!</h1>
  ```
- **Browser Screenshot**:
  ![Nginx Web Output](<../Screenshots/Docker_Fundamentals/nginx_browser.png>)

---

### 6. React Application (`React-app`)
- **Architecture**: Multi-stage build (build stage creates production bundle; production stage serves via static web server)
- **Container Port**: `3000` | **Host Port**: `3001`
- **Web Output Verification**:
  ```bash
  curl http://localhost:3001
  # Output: <h1>Hello World from React!</h1>
  ```
- **Browser Screenshot**:
  ![React Web Output](<../Screenshots/Docker_Fundamentals/react_browser.png>)

---

## Screenshot Evidence: Running Containers (`docker ps`)
![Running Docker Containers](<../Screenshots/Docker_Fundamentals/docker_apps_build_and_ps.png>)
