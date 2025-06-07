FROM quay.io/keycloak/keycloak:26.2

# Activer les options de prod
ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=info
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Copier les fichiers nécessaires
COPY ./realm-export.json /opt/keycloak/data/import/realm-export.json
COPY ./theme /opt/keycloak/themes
COPY ./start.sh /opt/keycloak/bin/start.sh

# Permissions + exécution
USER root
RUN chmod +x /opt/keycloak/bin/start.sh && \
    /opt/keycloak/bin/kc.sh build

USER 1000
EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/start.sh"]