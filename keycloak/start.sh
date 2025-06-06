#!/bin/bash

exec /opt/keycloak/bin/kc.sh start --optimized --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KEYCLOAK_HOSTNAME:-localhost}" \
  --hostname-admin="${KEYCLOAK_HOSTNAME:-localhost}" \
  --http-admin-user="${KEYCLOAK_ADMIN}" \
  --http-admin-password="${KEYCLOAK_ADMIN_PASSWORD}"