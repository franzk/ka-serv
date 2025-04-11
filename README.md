# ka-serv

A full-stack POC using Keycloak authentication.

This project includes:

- a Vue 3 frontend (`/frontend`)
- a Spring Boot backend (`/backend`)
- a Keycloak instance with a PostgreSQL database (via Docker)

---

## 🔧 Prerequisites

- Docker & Docker Compose
- Node.js ≥ 18 with `pnpm`
- Java 17+

---

## ⚙️ Environment Configuration (`.env`)

All configuration variables are centralized in a single `.env` file at the root of the project.

### Steps

1. Duplicate the example file:

   ```bash
   cp .env.example .env

   ```

2. Edit values as needed (e.g. ports, admin credentials, etc.)
