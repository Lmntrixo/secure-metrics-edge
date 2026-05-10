# secure-metrics-edge
Zero-Trust Docker Hardening: From a vulnerable Node.js container to a hardened Distroless production-ready image. Demonstrates read-only FS, cap-drop, non-root user, a## 🎯 Project Overview
This project demonstrates how to secure a Node.js microservice by migrating from a standard configuration (**Vulnerable**) to a high-security architecture (**Hardened**).

## 🛡️ Security Comparison

### Phase 1: The Vulnerable Stack (`/v1-vulnerable`)
*   **Base image:** `node:20` (Contains shell, compilers, and debug tools).
*   **User:** `root` (High risk of container breakout).
*   **FS:** Filesystem on Read-Write (Attackers can inject persistent backdoors).
*   **Hacking Demo:** 
    Using `hack.sh`, we use `docker exec` to gain root access, install malicious packages, and modify the source code in real-time.

### Phase 2: The Hardened Stack (`/v2-hardened`)
*   **Multi-stage build:** Only production dependencies are kept.
*   **Distroless image:** Final stage uses `gcr.io/distroless/nodejs20` (No shell, zero attack surface).
*   **Runtime Security:**
    *   `--read-only`: Filesystem is immutable.
    *   `--tmpfs`: Ephemeral storage (RAM) for logs, preventing persistent file injection.
    *   `--cap-drop=ALL`: No Linux capabilities granted.
    *   `USER nonroot`: Minimal privileges (default in Distroless).

---

## 🔍 The Blind Debugging Challenge

**PROBLEM:** How do you debug a container with no shell, no `ls`, no `cat`, and a read-only filesystem?  
**SOLUTION:** **The Sidecar Pattern**

I implemented a diagnostic method using a sidecar container to inspect the hardened target without compromising its integrity.

1.  **Shared Namespaces:** Attaching an Alpine container to the target's PID and Network stacks.
2.  **Filesystem Inspection:** Leveraging the `/proc` filesystem:
    `ls -l /proc/1/root/app`
3.  **The Distroless Proof:** Although we can use `nsenter` to enter the process, the lack of a shell/binaries prevents traditional attacks or manual tampering.

---

## 🚀 How to Run

1.  **Clone the repo**
2.  **Build & Run V1:** 
    ```bash
    docker build -t app-v1 -f v1-vulnerable/Dockerfile .
    docker run -d --name app_vulnerable -p 3001:3000 app-v1
    chmod +x v1-vulnerable/hack.sh && ./v1-vulnerable/hack.sh
    ```
3.  **Build & Run V2:** 
    ```bash
    docker build -t app-v2 -f v2-hardened/Dockerfile .
    chmod +x v2-hardened/deploy_v2.sh && ./v2-hardened/deploy_v2.sh
    ```
4.  **Audit & Debug:**
    ```bash
    chmod +x debug/debug.sh debug/debug_v2.sh
    ./debug/debug.sh    # Network & PID inspection
    ./debug/debug_v2.sh # Filesystem inspection via /proc
    ```
