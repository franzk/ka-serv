#!/bin/bash
set -e

echo "=== Entrée dans start.sh ==="

# Affichage debug des variables
echo "KEYCLOAK_HOSTNAME=${KEYCLOAK_HOSTNAME}"
echo "KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}"
echo "KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}"

# Valeurs par défaut si non définies
: "${KEYCLOAK_ADMIN:=admin}"
: "${KEYCLOAK_ADMIN_PASSWORD:=admin}"
: "${KEYCLOAK_HOSTNAME:=localhost}"

# Création de l'admin si base vide
if [ ! -f /opt/keycloak/data/h2/keycloak.mv.db ] && [ ! -f /opt/keycloak/data/import-done.flag ]; then
  echo "🛠️  Bootstrapping admin user..."
  /opt/keycloak/bin/kc.sh bootstrap-admin user \
    --user "$KEYCLOAK_ADMIN" \
    --password "$KEYCLOAK_ADMIN_PASSWORD"
  touch /opt/keycloak/data/import-done.flag
fi

exec /opt/keycloak/bin/kc.sh start \
  --optimized \
  --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KEYCLOAK_HOSTNAME}" \
  --hostname-admin="${KEYCLOAK_HOSTNAME}"