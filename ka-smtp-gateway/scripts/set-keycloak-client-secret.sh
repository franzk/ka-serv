#!/bin/bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────
# This script updates the CLIENT_SECRET line in
# ka-smtp-gateway/.env.prod with a given secret.
#
# It is intended to be called BEFORE docker-compose is run,
# so that the secret is already baked into the container at build time
#
# Usage:
#   ./set-keycloak-client-secret.sh --secret <value>
#
# Example:
#   ./set-keycloak-client-secret.sh --secret abcdef0123456789abcdef0123456789
#
# Requirements:
#   - The .env.prod file must exist
#   - It must contain a CLIENT_SECRET=... line
# ──────────────────────────────────────────────────────────────

# ── Parse CLI arguments ────────────────────────────────────────
SECRET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --secret) SECRET="$2"; shift ;;
    *) echo "❌ Unknown option: $1"; exit 1 ;;
  esac
  shift
done

: "${SECRET:?Missing --secret argument}"

ENV_FILE="./ka-smtp-gateway/.env.prod"

# ── Update the env file ────────────────────────────────────────
echo "✏️ Updating CLIENT_SECRET in $ENV_FILE..."

if [[ ! -f "$ENV_FILE" ]]; then
  echo "❌ Env file not found: $ENV_FILE"
  exit 1
fi

# Replace the existing CLIENT_SECRET=... line
if grep -q "^CLIENT_SECRET=" "$ENV_FILE"; then
  sed -i "s|^CLIENT_SECRET=.*|CLIENT_SECRET=$SECRET|" "$ENV_FILE"
else
  echo "CLIENT_SECRET=$SECRET" >> "$ENV_FILE"
fi

echo "✅ CLIENT_SECRET updated successfully in $ENV_FILE."