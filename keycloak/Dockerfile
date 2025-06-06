FROM quay.io/keycloak/keycloak:26.2

# Copie du thème personnalisé dans le répertoire des thèmes Keycloak
# COPY ./theme /opt/keycloak/themes/ka-theme

# CMD ["start", "--import-realm", "--http-enabled=true", "--http-port=8080", "--proxy-headers=xforwarded", "--hostname=${KEYCLOAK_HOSTNAME}", "--hostname-admin=${KEYCLOAK_HOSTNAME}"]

# FROM quay.io/keycloak/keycloak:24.0.3

# Configuration production
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=info

# Copie éventuelle de votre configuration (realm, thème, providers, etc.)
COPY ./realm-export.json /opt/keycloak/data/import/realm-export.json
COPY ./theme /opt/keycloak/themes

# Build optimisé pour la production
RUN /opt/keycloak/bin/kc.sh build

# Sécurité
USER 1000
EXPOSE 8080

# Commande de démarrage avec vos paramètres spécifiques
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized", "--import-realm", "--http-enabled=true", "--http-port=8080", "--proxy-headers=xforwarded", "--hostname=$(echo $KEYCLOAK_HOSTNAME)", "--hostname-admin=$(echo $KEYCLOAK_HOSTNAME)"]