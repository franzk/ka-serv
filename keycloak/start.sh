#!/bin/bash
set -e

echo "=== Entrée dans start.sh ==="

# Affichage debug des variables
echo "KEYCLOAK_HOSTNAME=${KEYCLOAK_HOSTNAME}"

# Valeurs par défaut si non définies
: "${KEYCLOAK_HOSTNAME:=localhost}"

exec /opt/keycloak/bin/kc.sh start --optimized --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KEYCLOAK_HOSTNAME}" \
  --hostname-admin="${KEYCLOAK_HOSTNAME}"