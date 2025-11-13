# 🐳 Docker Learning Repository

A comprehensive collection of Docker examples, tutorials, and best practices for learning containerization with Node.js and TypeScript applications.

## 📚 Table of Contents

- [What is Docker?](#what-is-docker)
- [Repository Structure](#repository-structure)
- [Examples](#examples)
- [Getting Started](#getting-started)
- [Docker Commands](#docker-commands)
- [Multi-Stage Builds](#multi-stage-builds)
- [Docker Compose](#docker-compose)
- [Best Practices](#best-practices)
- [Resources](#resources)

---

## What is Docker?

Docker is a platform that uses containerization to package applications with all their dependencies, ensuring they run consistently across different environments. 

### Key Concepts

- **Docker Image**: A blueprint or template for creating containers
- **Docker Container**: A running instance of an image
- **Dockerfile**: A text file with instructions to build an image
- **Docker Compose**: A tool for defining and running multi-container applications

### Why Docker?

- ✅ **Version Control**: Save entire application versions with dependencies
- ✅ **Consistency**: Same environment across development, testing, and production
- ✅ **Isolation**: Containers run independently without affecting the host system
- ✅ **Portability**: Run anywhere Docker is installed
- ✅ **Efficiency**: Lightweight compared to virtual machines

---

## Repository Structure

```
docker/
├── Dockerfile                    # Basic Node.js example
├── docker-compose.yml            # Multi-service example (PostgreSQL + Redis)
├── main.js                       # Simple Express server
├── package.json                  # Node.js dependencies
│
├── docker_project/
│   └── nodejs-docker-example/    # TypeScript multi-stage build example
│       ├── Dockerfile           # Multi-stage Dockerfile
│       ├── src/                 # TypeScript source files
│       └── dist/                # Compiled JavaScript
│
└── DockerTest/
    └── docker-code-files/
        ├── node-app/            # Simple Node.js app example
        └── ts-app/              # TypeScript app with Docker Compose
            ├── Dockerfile       # Multi-stage build with security
            └── docker-compose.yml  # Full stack (Backend + DB + Redis)
```

---

## Examples

### 1. Basic Node.js Application (`/`)

A simple Express.js server demonstrating basic Docker concepts.

**Files:**
- `Dockerfile` - Single-stage build
- `main.js` - Express server
- `docker-compose.yml` - PostgreSQL + Redis services

**Run:**
```bash
# Build the image
docker build -t node-app .

# Run the container
docker run -p 8000:8000 node-app
```

### 2. TypeScript Multi-Stage Build (`docker_project/nodejs-docker-example/`)

Demonstrates multi-stage builds for optimized production images.

**Features:**
- Multi-stage build (builder + runner)
- TypeScript compilation
- Production-optimized final image

**Run:**
```bash
cd docker_project/nodejs-docker-example
docker build -t nodejsexample .
docker run -p 8000:8000 nodejsexample
```

### 3. Full Stack Application (`DockerTest/docker-code-files/ts-app/`)

Complete example with backend, PostgreSQL, and Redis using Docker Compose.

**Features:**
- Multi-stage Dockerfile
- Non-root user for security
- Docker Compose orchestration
- Database and cache services

**Run:**
```bash
cd DockerTest/docker-code-files/ts-app
docker-compose up --build
```

---

## Getting Started

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed
- Basic knowledge of Node.js/TypeScript (optional)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Tgaurav1k/DOCKER.git
   cd DOCKER
   ```

2. **Verify Docker installation:**
   ```bash
   docker --version
   docker-compose --version
   ```

3. **Choose an example and follow its instructions above**

---

## Docker Commands

### Basic Commands

```bash
# Build an image
docker build -t <image-name> .

# Run a container
docker run -p <host-port>:<container-port> <image-name>

# Run interactively
docker run -it <image-name>

# List running containers
docker ps

# List all containers (including stopped)
docker container ls -a

# Start a stopped container
docker start <container-name>

# Stop a running container
docker stop <container-name>

# Execute command in running container
docker exec -it <container-name> <command>

# View container logs
docker logs <container-name>

# Remove a container
docker rm <container-name>

# Remove an image
docker rmi <image-name>
```

### Docker Compose Commands

```bash
# Start all services
docker-compose up

# Start in background (detached mode)
docker-compose up -d

# Stop all services
docker-compose down

# Rebuild and start
docker-compose up --build

# View logs
docker-compose logs
docker-compose logs <service-name>

# Check service status
docker-compose ps
```

---

## Multi-Stage Builds

Multi-stage builds allow you to use multiple `FROM` statements in a single Dockerfile, helping you:

1. **Reduce image size** - Only include production files
2. **Separate build from runtime** - Different environments for building vs running
3. **Avoid unnecessary files** - Exclude dev dependencies, build tools, cache

### Example Structure

```dockerfile
# Stage 1: Builder
FROM node:22.12.0-alpine3.21 AS builder
WORKDIR /build
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Runner (Production)
FROM node:22.12.0-alpine3.21 AS runner
WORKDIR /app
COPY --from=builder /build/dist ./dist
COPY --from=builder /build/package*.json ./
RUN npm install --omit=dev
CMD ["npm", "start"]
```

### Benefits

- **Smaller final image** - No build tools or source code
- **Faster deployments** - Smaller images transfer faster
- **Better security** - Fewer attack surfaces
- **Cleaner separation** - Build environment separate from runtime

---

## Docker Compose

Docker Compose allows you to define and run multi-container applications using a YAML file.

### Example: Full Stack Application

```yaml
services:
  backend:
    build: .
    ports:
      - "8000:8000"
  
  db:
    image: postgres:16
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
  
  redis:
    image: redis:7-alpine
```

### Key Features

- **Service orchestration** - Manage multiple containers together
- **Networking** - Containers can communicate by service name
- **Volumes** - Persistent data storage
- **Environment variables** - Configure services easily

---

## Best Practices

### 1. Use Alpine Linux
```dockerfile
FROM node:22-alpine  # ✅ Small and secure
# Avoid: FROM ubuntu   # ❌ Too large for small apps
```

### 2. Layer Caching
```dockerfile
# Copy dependencies first (changes less frequently)
COPY package*.json ./
RUN npm install

# Copy source code last (changes more frequently)
COPY . .
```

### 3. Multi-Stage Builds
Always use multi-stage builds for production to reduce image size.

### 4. Non-Root User
```dockerfile
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs
USER nodejs
```

### 5. Use .dockerignore
Create a `.dockerignore` file to exclude unnecessary files:
```
node_modules
.git
.env
dist
*.log
```

### 6. Specific Image Tags
```dockerfile
FROM node:22.12.0-alpine3.21  # ✅ Specific version
# Avoid: FROM node:latest     # ❌ Can break unexpectedly
```

### 7. Health Checks
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js
```

---

## Docker Networks

### Default Network
Docker creates a default `bridge` network. Containers on the same network can communicate by name.

### Create Custom Network
```bash
docker network create -d bridge my-network
```

### Inspect Network
```bash
docker network inspect bridge
```

### Connect Containers
```bash
docker run --network=my-network <image-name>
```

---

## Common Issues & Solutions

### Issue: Port Already in Use
```bash
# Find process using port
netstat -ano | findstr :8000

# Or use a different port
docker run -p 3000:8000 <image-name>
```

### Issue: Container Name Already Exists
```bash
# Remove existing container
docker rm <container-name>

# Or use a different name
docker run --name new-name <image-name>
```

### Issue: Permission Denied
```bash
# Run with proper user permissions
# Use non-root user in Dockerfile (see Best Practices)
```

---

## Resources

### Official Documentation
- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

### Learning Resources
- [Docker Getting Started](https://docs.docker.com/get-started/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

### Image Registries
- [Docker Hub](https://hub.docker.com/) - Public registry for Docker images

---

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

---

## License

This repository is for educational purposes. Feel free to use and modify as needed.

---

## Author

**Gaurav Kumar**

- GitHub: [@Tgaurav1k](https://github.com/Tgaurav1k)
- Repository: [DOCKER](https://github.com/Tgaurav1k/DOCKER)

---

## Quick Reference

### Build and Run
```bash
docker build -t my-app .
docker run -p 8000:8000 my-app
```

### Docker Compose
```bash
docker-compose up -d
docker-compose down
```

### Useful Commands
```bash
docker ps                    # List running containers
docker images               # List images
docker logs <container>     # View logs
docker exec -it <container> bash  # Enter container
```

---

**Happy Docker Learning! 🐳**

