# ka-serv

A full-stack proof of concept (POC) featuring user authentication via Keycloak.

---

## Architecture

![Architecture Diagram](./doc/ka-architecture.png)

| Service      | Port | Description                                                                                                                                                                                        |
| ------------ | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Frontend     | 5173 | Vue 3 application for user interaction                                                                                                                                                             |
| Backend      | 5027 | Spring Boot API and business logic                                                                                                                                                                 |
| Keycloak     | 5028 | Identity and access management (authentication and authorization)                                                                                                                                  |
| Mailer       | 5030 | Spring Boot service for sending emails                                                                                                                                                             |
| SMTP Gateway | 1025 | Node.js service that intercepts SMTP requests from Keycloak, extracts email data, and forwards it as HTTP REST calls to the mailer service. Enables Keycloak to send emails via the mailer service |

---

## Prerequisites

- Docker & Docker Compose
- Node.js ≥ 18 with `pnpm`
- Java 17+

---

## ▶ Running the Project in Local Environment

### 1. Start the infrastructure (Keycloak + DB)

```bash
cd dev
docker-compose up
```

This will spin up Keycloak and the associated PostgreSQL database.

### 2. Start the Frontend (Vue 3)

```bash
cd ks-front
pnpm install
pnpm run dev
```

Available at http://localhost:5173

### 3. Start the Backend (Spring Boot + Gradle)

```bash
cd ks-back
./gradlew bootRun
```

Backend is exposed at http://localhost:5027

### 4. Check it

Visit: http://localhost:5173

---

## ▶ Deploying the Project in Production

### 1. Configure the secrets

| Secret Name                 | Content                  |
| --------------------------- | ------------------------ |
| KC_BOOTSTRAP_ADMIN_USERNAME | Keycloak admin login     |
| KC_BOOTSTRAP_ADMIN_PASSWORD | Keycloak admin password  |
| KEYCLOAK_HOSTNAME           | Keycloak url             |
| VPS_HOST                    | IP ou domaine de ton VPS |
| VPS_USER                    | SSH user                 |
| VPS_SSH_KEY                 | SSH private key          |

### 2. Deploy

You can deploy the project

- either manually from the GitHub Actions interface,
- or automatically by pushing to the `main` branch.
