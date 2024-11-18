# Dockerfile for Node.js Application

## Overview

This Dockerfile builds a lightweight and production-ready Docker image for a Node.js application. It uses a multi-stage build process to ensure smaller image size by separating the build dependencies from the final runtime image.

---

## Dockerfile Details

### 1. Base Image

- **Image Used**: `node:18-alpine`
  - Lightweight Node.js image based on Alpine Linux.

### 2. Multi-Stage Build

#### **Stage 1: Build Stage**

- **Base Image**: `node:18-alpine`
- **Purpose**: Install dependencies, build the application, and prepare the production-ready files.
  
**Steps:**
1. Install required dependencies:
   - Git (`apk add --no-cache git`)
   - Build tools and Python for building native Node.js modules (`apk --no-cache add --virtual builds-deps build-base python3`).
2. Set the working directory to `/app`.
3. Copy the `package.json` file to the container.
4. Install project dependencies using `npm i --legacy-peer-deps`.
5. Copy the entire application source code to the container.
6. Build the application using `npm run build`.

---

#### **Stage 2: Final Stage**

- **Base Image**: `node:18-alpine`
- **Purpose**: Create a minimal image with only the production-ready files.

**Steps:**
1. Set the working directory to `/app`.
2. Copy the `dist/` folder (build output), `node_modules/`, and `package.json` from the build stage.
3. Expose port `5102` for the application.
4. Set the `HOSTNAME` environment variable to `0.0.0.0`.
5. Start the application using the `node dist/main.js` command.

---

## Build and Run Instructions

### Build the Image

Run the following command to build the Docker image:

```bash
docker build -t your-image-name .
