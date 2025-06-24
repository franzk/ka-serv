# ka-serv

A full-stack proof of concept (POC) featuring user authentication via Keycloak.

---

## Architecture

![Architecture Diagram](./doc/ka-architecture.png)

### Services Overview

| Service      | Port | Technology   | Description                          |
| ------------ | ---- | ------------ | ------------------------------------ |
| Frontend     | 5173 | Vue 3 + Vite | User interface SPA                   |
| Backend      | 5027 | Spring Boot  | REST API and business logic          |
| Keycloak     | 5028 | Java         | Identity and access management (IAM) |
| Mailer       | 5030 | Spring Boot  | Email sending service                |
| SMTP Gateway | 1025 | Node.js      | SMTP → HTTP proxy for Keycloak       |
| PostgreSQL   | 5432 | Database     | Keycloak database                    |

### Architecture Flow

1. **User Authentication**: Frontend → Keycloak (OAuth2/OIDC)
2. **API Calls**: Frontend → Backend (with JWT tokens)
3. **Email Sending**: Keycloak → SMTP Gateway → Mailer Service
4. **Data Persistence**: Keycloak → PostgreSQL

---

## Prerequisites

- Docker & Docker Compose
- Node.js ≥ 18 with `pnpm`
- Java 17+
- Git

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
cd ka-front
pnpm install
pnpm run dev
```

Available at http://localhost:5173

### 3. Start the Backend (Spring Boot + Gradle)

```bash
cd ka-back
./gradlew bootRun
```

Backend is exposed at http://localhost:5027

### 4. Verify Setup

Visit: http://localhost:5173

---

## ▶ Deploying the Project in Production

### 🚀 Manual deployment

#### 1. Prepare environment variables

##### Project root

```bash
cp .env.example .env
```

Then open .env and fill in the required values :

- KEYCLOAK_URL
- KEYCLOAK_ISSUER
- KEYCLOAK_TOKEN_URL

##### Keycloak

```bash
cd keycloak
cp .env.prod.example .env.prod
```

Then open .env.prod and fill in the required values:

- KC_BOOTSTRAP_ADMIN_USERNAME
- KC_BOOTSTRAP_ADMIN_PASSWORD
- KEYCLOAK_HOSTNAME — must match KEYCLOAK_URL

##### Ka-mailer

```bash
cd ka-mailer
cp .env.example .env
```

Then open .env and fill in the required values:

- SMTP_HOST
- SMTP_PORT
- SMTP_USERNAME
- SMTP_PASSWORD

#### 2. Launch the deployment script

From the root of the project:

```bash
./deploy.sh
```

### 🤖 CI/CD with GitHub Actions

Configure these secrets in your GitHub repository settings (`Settings` > `Secrets and variables` > `Actions`):

#### Authentication & Infrastructure

| Secret        | Description      | Example                               |
| ------------- | ---------------- | ------------------------------------- |
| `VPS_HOST`    | Server IP/domain | `192.168.1.100` or `your-server.com`  |
| `VPS_USER`    | SSH username     | `deploy`                              |
| `VPS_SSH_KEY` | SSH private key  | `-----BEGIN OPENSSH PRIVATE KEY-----` |

#### Keycloak Configuration

| Secret                        | Description            |
| ----------------------------- | ---------------------- |
| `KC_BOOTSTRAP_ADMIN_USERNAME` | Initial admin username |
| `KC_BOOTSTRAP_ADMIN_PASSWORD` | Initial admin password |
| `KEYCLOAK_HOSTNAME`           | Public Keycloak URL    |

#### Email Configuration

| Secret          | Description        | Notes                                                  |
| --------------- | ------------------ | ------------------------------------------------------ |
| `SMTP_HOST`     | SMTP server        | e.g., `smtp.gmail.com`, `smtp.outlook.com`             |
| `SMTP_PORT`     | SMTP port          | Usually `465` (SSL)                                    |
| `SMTP_USERNAME` | Email address      | Sender email address                                   |
| `SMTP_PASSWORD` | Email password     | Password for the SMTP account                          |
| `SMTP_AUTH`     | Use authentication | Set to true if the SMTP server requires authentication |
| `SMTP_SSL`      | Enable SSL/TLS     | Set to true to use a secure SSL/TLS connection         |

### Deployment Triggers

You can deploy the project:

- ✅ **Manual**: GitHub Actions tab → "Deploy to Production"
- ✅ **Automatic**: Push to `main` branch

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and test thoroughly
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

### Development Guidelines

- ✅ Follow existing code style and conventions
- ✅ Add tests for new functionality
- ✅ Update documentation for API changes
- ✅ Test in both development and production environments
- ✅ Keep commits atomic and well-described

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 💬 Support

- 📧 **Email**: <koehler.francois@gmail.com>
- 🐛 **Issues**: [GitHub Issues](https://github.com/franzk/ka-serv/issues)
