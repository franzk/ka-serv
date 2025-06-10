#!/bin/bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────
# Script: keycloak-set-client-secret.sh
#
# Description:
#   Sets (or updates) the secret for a specific Keycloak client.
#   This is typically used for technical clients (e.g., backends,
#   service accounts) that authenticate via client credentials.
#
# Usage:
#   docker exec <keycloak_container> bash -c "
#     bash /opt/keycloak/bin/scripts/keycloak-set-client-secret.sh \
#       --client-id <client_id> \
#       --client-secret <client_secret> \
#       --server-url <keycloak_base_url> \
#       --realm <realm_name> \
#       --admin-user <admin_username> \
#       --admin-password <admin_password>
#   "
#
# Example:
#   docker exec ka-keycloak bash -c "
#     bash /opt/keycloak/bin/scripts/keycloak-set-client-secret.sh \
#       --client-id my-service \
#       --client-secret s3cr3t \
#       --server-url https://auth.myserver.com \
#       --realm my-realm \
#       --admin-user admin \
#       --admin-password admin
#   "
#
# Notes:
# - Requires Keycloak CLI admin tool (kcadm.sh) to be available.
# - Must be run inside a container or environment where Keycloak is accessible.
# - Uses the "master" realm for admin authentication.
# - Cleans up the auth context after injection.
# ──────────────────────────────────────────────────────────────

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --client-id) CLIENT_ID="$2"; shift ;;
    --client-secret) CLIENT_SECRET="$2"; shift ;;
    --server-url) SERVER_URL="$2"; shift ;;
    --realm) REALM="$2"; shift ;;
    --admin-user) ADMIN_USER="$2"; shift ;;
    --admin-password) ADMIN_PASS="$2"; shift ;;
    *) echo "❌ Unknown option: $1"; exit 1 ;;
  esac
  shift
done

# Validate required arguments
: "${CLIENT_ID:?Missing --client-id}"
: "${CLIENT_SECRET:?Missing --client-secret}"
: "${SERVER_URL:?Missing --server-url}"
: "${REALM:?Missing --realm}"  
: "${ADMIN_USER:?Missing --admin-user}"
: "${ADMIN_PASS:?Missing --admin-password}"

echo "🔐 Setting client secret for '$CLIENT_ID' in realm '$REALM' at '$SERVER_URL'..."

# Authenticate using the master realm
/opt/keycloak/bin/kcadm.sh config credentials \
  --server "$SERVER_URL" \
  --realm master \
  --user "$ADMIN_USER" \
  --password "$ADMIN_PASS"

# Lookup the internal UUID of the client based on clientId
# client_uuid=$(
#  /opt/keycloak/bin/kcadm.sh get clients -r "$REALM" --fields id,clientId \
#  | jq -r ".[] | select(.clientId==\"$CLIENT_ID\") | .id"
#)

client_uuid=$(
  /opt/keycloak/bin/kcadm.sh get clients -r "$REALM" --fields id,clientId \
  | grep "\"clientId\" : \"$CLIENT_ID\"" -B 1 \
  | grep '"id"' \
  | sed 's/.*"id" : "\(.*\)".*/\1/'
)

# Fail if the client was not found
if [[ -z "$client_uuid" ]]; then
  echo "❌ Client '$CLIENT_ID' not found in realm '$REALM'" >&2
  exit 1
fi

# Inject the new secret
/opt/keycloak/bin/kcadm.sh update clients/"$client_uuid" -r "$REALM" -s secret="$CLIENT_SECRET"

echo "✅ Secret for '$CLIENT_ID' updated successfully."

# Clear auth context
/opt/keycloak/bin/kcadm.sh config unset