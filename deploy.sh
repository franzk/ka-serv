#!/bin/bash
set -euo pipefail

echo "🚀 Starting Docker Compose..."
docker compose up -d --build

echo "✅ Deployment complete."