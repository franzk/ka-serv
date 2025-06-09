#!/bin/bash
set -euo pipefail

echo "🔐 Generating random secret..."
KA_SMTP_GATEWAY_SECRET=$(openssl rand -hex 32)

echo "✍️ Generating .env.prod for ka-smtp-gateway..."
./ka-smtp-gateway/scripts/set-keycloak-client-secret.sh \
  --secret "$KA_SMTP_GATEWAY_SECRET"

echo "🚀 Starting Docker Compose..."
docker compose up -d --build

echo "🔐 Injecting secret into Keycloak..."
./keycloak/scripts/inject-ka-smtp-gateway-client-secret.sh \
  --secret "$KA_SMTP_GATEWAY_SECRET"

echo "✅ Deployment complete."