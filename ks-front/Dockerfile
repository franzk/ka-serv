# Build stage
FROM node:23-slim AS builder

WORKDIR /app
COPY . .
RUN corepack enable && corepack prepare pnpm@latest --activate
RUN CI=true pnpm install
RUN pnpm run build

# Serve stage
FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Optional: add custom nginx config here
EXPOSE 80