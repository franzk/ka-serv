#!/bin/bash
set -e

HOSTNAME="${KEYCLOAK_HOSTNAME:-localhost}"
ADMIN="${KEYCLOAK_ADMIN:-admin}"
ADMIN_PASSWORD="${KEYCLOAK_ADMIN_PASSWORD:-admin}"

exec /opt/keycloak/bin/kc.sh start --optimized --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${HOSTNAME}" \
  --hostname-admin="${HOSTNAME}" \
  --http-admin-user="${ADMIN}" \
  --http-admin-password="${ADMIN_PASSWORD}"