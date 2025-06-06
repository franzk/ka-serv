#!/bin/bash
set -e

# Valeurs par défaut si non définies
: "${KEYCLOAK_ADMIN:=admin}"
: "${KEYCLOAK_ADMIN_PASSWORD:=admin}"
: "${KEYCLOAK_HOSTNAME:=localhost}"

exec /opt/keycloak/bin/kc.sh start --optimized --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KEYCLOAK_HOSTNAME}" \
  --hostname-admin="${KEYCLOAK_HOSTNAME}" \
  --http-admin-user="${KEYCLOAK_ADMIN}" \
  --http-admin-password="${KEYCLOAK_ADMIN_PASSWORD}"