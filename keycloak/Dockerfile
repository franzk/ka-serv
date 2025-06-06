FROM quay.io/keycloak/keycloak:26.2

# Configuration production
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=info

# Copie de la configuration (realm et thème)
COPY ./realm-export.json /opt/keycloak/data/import/realm-export.json
COPY ./theme /opt/keycloak/themes

# Build optimisé pour la production
RUN /opt/keycloak/bin/kc.sh build

# Créer un script d'entrée pour gérer les variables
RUN echo '#!/bin/bash\n\
exec /opt/keycloak/bin/kc.sh start --optimized --import-realm \
  --http-enabled=true \
  --http-port=8080 \
  --proxy-headers=xforwarded \
  --hostname="${KEYCLOAK_HOSTNAME:-localhost}" \
  --hostname-admin="${KEYCLOAK_HOSTNAME:-localhost}"' > /opt/keycloak/bin/start.sh && \
    chmod +x /opt/keycloak/bin/start.sh

# Sécurité
USER 1000
EXPOSE 8080

# Utiliser le script d'entrée
ENTRYPOINT ["/opt/keycloak/bin/start.sh"]