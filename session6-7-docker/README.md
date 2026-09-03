# Docker Fundamentals Homework Solutions

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task: Hello World Applications

Create simple Hello World web applications using Docker for multiple technologies.

---

### Application Structure

```
temp_docker_fundamentals/
├── nodejs-app/
│   ├── app.js
│   ├── package.json
│   └── Dockerfile
├── react-app/
│   ├── Dockerfile
│   └── (React app files)
├── python-app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── java-app/
│   ├── HelloWorld.java
│   └── Dockerfile
├── apache-app/
│   ├── index.html
│   └── Dockerfile
└── nginx-app/
    ├── index.html
    └── Dockerfile
```

---

## 1. Node.js Application

### Workflow Performed

- Created `nodejs-app` folder
- Added Express.js application code
- Created Dockerfile with Node.js base image
- Built image using `docker build -t nodejs-hello .`
- Ran container with `docker run -p 3000:3000 nodejs-hello`
- Verified Hello World displayed on `http://localhost:3000`

### Output

![Node.js app build](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.17.15 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.20.25 PM.png>)

---

## 2. React Application

### Workflow Performed

- Created React app using `create-react-app`
- Created Dockerfile with multi-stage build
- Built image using `docker build -t react-hello .`
- Ran container with `docker run -p 3001:80 react-hello`
- Verified Hello World displayed on `http://localhost:3001`

### Output


![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.26.49 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.27.11 PM.png>)
---

## 3. Python Application (Flask)

### Workflow Performed

- Created `python-app` folder
- Added Flask application code
- Created Dockerfile with Python base image
- Built image using `docker build -t python-hello .`
- Ran container with `docker run -p 5000:5000 python-hello`
- Verified Hello World displayed on `http://localhost:5000`

### Output

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.44.26 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.44.35 PM.png>)

---

## 4. Java Application

### Workflow Performed

- Created `java-app` folder
- Added simple Java application with embedded server
- Created Dockerfile with OpenJDK base image
- Built image using `docker build -t java-hello .`
- Ran container with `docker run -p 8080:8080 java-hello`
- Verified Hello World displayed on `http://localhost:8080`

### Output

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.57.42 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 2.58.02 PM.png>)

---

## 5. Apache Web Server

### Workflow Performed

- Created `apache-app` folder
- Added `index.html` with Hello World content
- Created Dockerfile using `httpd` base image
- Built image using `docker build -t apache-hello .`
- Ran container with `docker run -p 8081:80 apache-hello`
- Verified Hello World displayed on `http://localhost:8081`

### Output

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 5.30.03 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 5.30.21 PM.png>)

---

## 6. Nginx Application

### Workflow Performed

- Created `nginx-app` folder
- Added `index.html` with Hello World content
- Created Dockerfile using `nginx` base image
- Built image using `docker build -t nginx-hello .`
- Ran container with `docker run -p 8082:80 nginx-hello`
- Verified Hello World displayed on `http://localhost:8082`

### Output

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 5.33.19 PM.png>)

![alt text](<../Screenshots/Docker_Fundamentals/Screenshot 2026-09-02 at 5.33.39 PM.png>)

---

### Quick Verification Commands

```bash
# Check all running containers
docker ps

# Test all applications
curl http://localhost:3000  # Node.js
curl http://localhost:3001  # React
curl http://localhost:5000  # Python
curl http://localhost:8080  # Java
curl http://localhost:8081  # Apache
curl http://localhost:8082  # Nginx
```

---

## Combined Summary

### What We Learned

| Task | Key Learning |
|------|--------------|
| **Node.js** | Created Express server and containerized with Node base image |
| **React** | Used multi-stage Docker build for optimized production image |
| **Python** | Created Flask application and containerized with Python base image |
| **Java** | Created simple Java HTTP server using built-in HttpServer class |
| **Apache** | Used official httpd image to serve static HTML content |
| **Nginx** | Used official nginx image to serve static HTML content |

### Key Docker Commands

```bash
# Build image
docker build -t <image-name> .

# Run container
docker run -d -p <host-port>:<container-port> --name <container-name> <image-name>

# View running containers
docker ps

# Stop container
docker stop <container-name>

# Remove container
docker rm <container-name>

# Remove image
docker rmi <image-name>
```

### Port Mapping Summary

| Application | Host Port | Container Port |
|-------------|-----------|----------------|
| Node.js | 3000 | 3000 |
| React | 3001 | 80 |
| Python | 5000 | 5000 |
| Java | 8080 | 8080 |
| Apache | 8081 | 80 |
| Nginx | 8082 | 80 |

---
