#!/bin/bash
set -euo pipefail

echo "🚀 Starting Docker Compose..."
docker compose -f docker-compose.yml -f docker-compose.proxy.yml up -d

echo "✅ Deployment complete."