#!/bin/bash
set -euo pipefail

PROJECT="ka-serv"
ENV_FILE=".env"

# Load .env into the shell (so deploy.sh can read PROXY_NETWORK_NAME, etc.)
if [[ -f "$ENV_FILE" ]]; then
  # Normalize line endings (avoid CRLF issues)
  sed -i 's/\r$//' "$ENV_FILE"
  set -a # Export all variables
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a # Stop exporting all variables
  echo "✅ Loaded environment variables from $ENV_FILE"
else
  echo "❌️ $ENV_FILE not found."
  exit 1
fi

# Determine which docker-compose files to use based on PROXY_NETWORK_NAME
BASE_ARGS=(--env-file "$ENV_FILE" -p "$PROJECT" -f docker-compose.yml)

if [[ -n "${PROXY_NETWORK_NAME:-}" ]]; then
  echo "Proxy mode enabled: PROXY_NETWORK_NAME=$PROXY_NETWORK_NAME"
  docker network inspect "$PROXY_NETWORK_NAME" >/dev/null 2>&1 || {
    echo "❌ Docker network '$PROXY_NETWORK_NAME' not found"
    exit 1
  }
  COMPOSE_ARGS=("${BASE_ARGS[@]}" -f docker-compose.proxy.yml)
else
  echo "Proxy mode disabled (generic mode)"
  COMPOSE_ARGS=("${BASE_ARGS[@]}")
fi

echo "Starting Docker Compose..."
docker compose "${COMPOSE_ARGS[@]}" up -d --build --force-recreate

docker compose "${COMPOSE_ARGS[@]}" ps
echo "✅ Deployment complete."
