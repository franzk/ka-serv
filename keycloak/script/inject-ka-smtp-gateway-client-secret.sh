#!/bin/bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────
# This script injects a specific client secret into Keycloak
# for the technical client 'ka-smtp-gateway-client'.
#
# Usage:
#   ./inject-ka-smtp-gateway-client-secret.sh --secret <value>
#
# Requirements:
#   - keycloak/.env.prod must define:
#       - KEYCLOAK_HOSTNAME
#       - KC_BOOTSTRAP_ADMIN_USERNAME
#       - KC_BOOTSTRAP_ADMIN_PASSWORD
# ──────────────────────────────────────────────────────────────

# ── Parse arguments ────────────────────────────────────────────
SECRET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --secret) SECRET="$2"; shift ;;
    *) echo "❌ Unknown option: $1"; exit 1 ;;
  esac
  shift
done

: "${SECRET:?Missing required --secret argument}"

# ── Load Keycloak env vars ─────────────────────────────────────
echo "📦 Loading Keycloak environment variables from keycloak/.env.prod..."
set -a
source ./keycloak/.env.prod
set +a

# ── Define constants ───────────────────────────────────────────
CLIENT_ID="ka-smtp-gateway-client"
REALM="kaserv"

# ── Inject into Keycloak ───────────────────────────────────────
echo "🔐 Injecting client secret for '$CLIENT_ID' in realm '$REALM'..."

docker exec ka-keycloak bash -c "
  bash /opt/keycloak/bin/scripts/keycloak-set-client-secret.sh \
    --client-id '$CLIENT_ID' \
    --client-secret '$SECRET' \
    --server-url '$KEYCLOAK_HOSTNAME' \
    --realm '$REALM' \
    --admin-user '$KC_BOOTSTRAP_ADMIN_USERNAME' \
    --admin-password '$KC_BOOTSTRAP_ADMIN_PASSWORD'
"

echo "✅ Client secret successfully injected for '$CLIENT_ID'."