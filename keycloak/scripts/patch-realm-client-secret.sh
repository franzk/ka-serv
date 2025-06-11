#!/bin/bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────
# patch-realm-client-secret.sh
# Replace the clientSecret for a given clientId in realm-export.json
#
# Usage:
#   ./patch-realm-secret.sh <client-id> <client-secret>
# ─────────────────────────────────────────────────────────────

REALM_FILE="../realm-export.json"

CLIENT_ID="${1:-}"
CLIENT_SECRET="${2:-}"

if [[ -z "$CLIENT_ID" || -z "$CLIENT_SECRET" ]]; then
  echo "❌ Usage: $0 <client-id> <client-secret>"
  exit 1
fi

if [[ ! -f "$REALM_FILE" ]]; then
  echo "❌ File not found: $REALM_FILE"
  exit 1
fi

echo "🔍 Checking for client '$CLIENT_ID' in $REALM_FILE..."

MATCH_COUNT=$(jq --arg id "$CLIENT_ID" '[.clients[] | select(.clientId == $id)] | length' "$REALM_FILE")
if [[ "$MATCH_COUNT" -eq 0 ]]; then
  echo "❌ Client '$CLIENT_ID' not found in $REALM_FILE"
  exit 1
fi

echo "🔧 Replacing secret for '$CLIENT_ID'..."

tmpfile=$(mktemp)

jq --arg id "$CLIENT_ID" --arg secret "$CLIENT_SECRET" '
  .clients |= map(
    if .clientId == $id then
      .secret = $secret
    else
      .
    end
  )
' "$REALM_FILE" > "$tmpfile"

mv "$tmpfile" "$REALM_FILE"

echo "✅ Secret for '$CLIENT_ID' replaced successfully."