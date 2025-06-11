# Use official Keycloak base image
FROM quay.io/keycloak/keycloak:26.2

# Enable production features
ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=info

# Copy realm export for initial import (used with --import-realm)
COPY ./realm-export.json /opt/keycloak/data/import/realm-export.json

# Copy custom theme
COPY ./theme /opt/keycloak/themes/ka-theme

# Copy custom start script
COPY ./scripts/start.sh /opt/keycloak/bin/start.sh

# Switch to root to set permissions and install scripts
USER root

# Copy the client secret injection script
# COPY ./scripts/keycloak-set-client-secret.sh /opt/keycloak/bin/scripts/keycloak-set-client-secret.sh

# Make scripts executable
#RUN chmod +x /opt/keycloak/bin/scripts/keycloak-set-client-secret.sh && \
RUN chmod +x /opt/keycloak/bin/start.sh 

# Build Keycloak with custom configurations
RUN /opt/keycloak/bin/kc.sh build

# Switch back to default non-root user
USER 1000

# Expose default Keycloak port
EXPOSE 8080

# Use custom start script as entrypoint
ENTRYPOINT ["/opt/keycloak/bin/start.sh"]