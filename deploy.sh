#!/bin/bash
set -euo pipefail

PROJECT="ka-serv"
BASE_ARGS=(-p "$PROJECT" -f docker-compose.yml)

if [[ -n "${PROXY_NETWORK_NAME:-}" ]]; then
  echo "🔌 Proxy mode enabled: PROXY_NETWORK_NAME=$PROXY_NETWORK_NAME"
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
