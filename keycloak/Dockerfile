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
COPY ./start.sh /opt/keycloak/bin/start.sh
RUN chmod +x /opt/keycloak/bin/start.sh

# Sécurité
USER 1000
EXPOSE 8080

# Utiliser le script d'entrée
ENTRYPOINT ["/opt/keycloak/bin/start.sh"]