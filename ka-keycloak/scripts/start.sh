#!/bin/bash
set -e

echo "=== Enter into Keycloak start.sh ==="

# Debugging: show environment variables
echo "KC_HOSTNAME=${KC_HOSTNAME}"
echo "KC_HOSTNAME_ADMIN=${KC_HOSTNAME_ADMIN}"

exec /opt/keycloak/bin/kc.sh start \
  --optimized \
  --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KC_HOSTNAME}" \
  --hostname-admin="${KC_HOSTNAME_ADMIN}"