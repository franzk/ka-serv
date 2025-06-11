#!/bin/bash
set -euo pipefail

echo "🔐 Generating random secret..."
KA_SMTP_GATEWAY_SECRET=$(openssl rand -hex 32)

echo "✍️ Generating .env.prod for ka-smtp-gateway..."
./ka-smtp-gateway/scripts/set-keycloak-client-secret.sh \
  --secret "$KA_SMTP_GATEWAY_SECRET"

# echo "🔐 Injecting secret into Keycloak..."
./keycloak/scripts/patch-realm-client-secret.sh \
  --client-id "ka-smtp-gateway-client" \
  --client-secret "$KA_SMTP_GATEWAY_SECRET"


echo "🚀 Starting Docker Compose..."
docker compose up -d --build

echo "✅ Deployment complete."