#!/bin/bash
set -euo pipefail

echo "🚀 Starting Docker Compose..."
docker compose -f docker-compose.yml -f docker-compose.proxy.yml up --build --force-recreate -d

echo "✅ Deployment complete."