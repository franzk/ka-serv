# ka-serv

A full-stack proof of concept (POC) featuring user authentication via Keycloak.

---

## Architecture

![Architecture Diagram](./doc/ka-architecture.png)

### Services Overview

| Service       | Port | Technology   | Description                            |
|---------------|------|--------------|----------------------------------------|
| Frontend      | 5173 | Vue 3 + Vite | User interface (SPA)                   |
| Gateway       | 5080 | Spring Boot  | API Gateway (single entry point)       |
| Backend       | 5027 | Spring Boot  | REST API and business logic            |
| Keycloak      | 5028 | Keycloak     | Identity and access management (IAM)   |
| PostgreSQL    | 5432 | Database     | Keycloak database                      |
| SMTP Bridge   | 1025 | Node.js      | SMTP → HTTP bridge for Keycloak emails |
| Mailer        | 5030 | Spring Boot  | Email delivery service (HTTP API)      |
| MailHog (dev) | 5125 | MailHog      | Dev mailbox UI                         |

### Architecture Flow

1. **User Authentication**: Frontend → Keycloak (OAuth2/OIDC)
2. **API Calls**: Frontend → Gateway → Backend (with JWT tokens)
3. **Identity Emails**: Keycloak → SMTP Bridge (SMTP) → Mailer Service (HTTP API)
4. **Data Persistence**: Keycloak → PostgreSQL

---

## Prerequisites

- Docker & Docker Compose
- Node.js ≥ 18 with `pnpm`
- JDK 25
- Git

---

## ▶ Running the Project in Local Environment

### 1. Start the infrastructure (Keycloak + DB + MailHog + SMTP Bridge for dev)

```bash
cd dev
docker compose up
```

This will spin up Keycloak and the associated PostgreSQL database.

### 2. Start the Frontend (Vue 3)

```bash
cd ka-front
pnpm install
pnpm run dev
```

Available at http://localhost:5173

### 3. Start the API Gateway (Spring Boot + Gradle)

```bash
cd ka-gateway
./gradlew bootRun
```

API Gateway is exposed at http://localhost:5080

### 4. Start the Backend (Spring Boot + Gradle)

```bash
cd ka-back
./gradlew bootRun
```

### 5. Start the Mailer Service (Spring Boot + Gradle)

```bash
cd ka-mailer
./gradlew bootRun
```

### 6. Verify Setup

- Visit: http://localhost:5173
- Register a new user
- Get registration email  with MailHog at http://localhost:5125
- Confirm email

---

## ▶ Deploying the Project in Production

### Manual deployment

#### 1. Prepare environment variables

##### Project root

```bash
cp env.example .env
```

Edit .env and fill in the required values.

#### 2. Launch the deployment script

From the root of the project:

```bash
./deploy.sh
```

### CI/CD with GitHub Actions

Configure these secrets in your GitHub repository settings 
(`Settings` > `Secrets and variables` > `Actions`):

#### Authentication & Infrastructure

| Secret     | Description      | Example                               |
| ---------- | ---------------- | ------------------------------------- |
| `SSH_HOST` | Server IP/domain | `192.168.1.100` or `your-server.com`  |
| `SSH_USER` | SSH username     | `deploy`                              |
| `SSH_KEY`  | SSH private key  | `-----BEGIN OPENSSH PRIVATE KEY-----` |

You can use `./deploy/setup_ssh_user.sh` to create a user and a ssh key on your server.

### Deployment Triggers

You can deploy the project:

- **Manual**: GitHub Actions tab → "Deploy to Production"

## Scope

This project is a technical proof of concept focusing on:
- OAuth2 / OIDC authentication with Keycloak
- Token-based API security
- Clean separation of concerns
- Centralized email delivery architecture

It is not intended to be production-ready as-is, but to serve as a reference architecture.

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and test thoroughly
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

### Development Guidelines

- Follow existing code style and conventions
- Add tests for new functionality
- Update documentation for API changes
- Test in both development and production environments
- Keep commits atomic and well-described

---

## Support

- **Email**: <koehler.francois@gmail.com>
- **Issues**: [GitHub Issues](https://github.com/franzk/ka-serv/issues)
